// SpacesViewModel.swift
// Noon
// Purpose: Manages shared space data and member operations

import Foundation
import SwiftUI

@MainActor
class SpacesViewModel: ObservableObject {
    @Published var spaces: [Space] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func loadSpaces() async {
        isLoading = true
        errorMessage = nil

        do {
            spaces = try await apiClient.request(endpoint: .getSpaces)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func createSpace(name: String, budgetAmount: Decimal, budgetPeriod: String, color: String, icon: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let _: Space = try await apiClient.request(
                endpoint: .createSpace(
                    name: name,
                    budgetAmount: budgetAmount,
                    budgetPeriod: budgetPeriod,
                    color: color,
                    icon: icon
                )
            )
            await loadSpaces()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
