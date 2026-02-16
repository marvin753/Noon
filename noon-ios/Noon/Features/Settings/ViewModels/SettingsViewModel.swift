// SettingsViewModel.swift
// Noon
// Purpose: Manages user settings and profile updates

import Foundation
import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiClient = APIClient.shared

    func loadUser() async {
        isLoading = true
        errorMessage = nil

        do {
            user = try await apiClient.request(endpoint: .getCurrentUser)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func updateProfile(name: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let updatedUser: User = try await apiClient.request(endpoint: .updateUser(name: name))
            user = updatedUser
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
