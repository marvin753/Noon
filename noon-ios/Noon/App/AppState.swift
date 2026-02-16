// AppState.swift
// Noon
// Purpose: Global app state management including authentication status and user session

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var isLoading: Bool = false

    private let tokenManager = TokenManager.shared
    private let apiClient = APIClient.shared

    init() {
        apiClient.appState = self
        checkAuthenticationStatus()
    }

    func checkAuthenticationStatus() {
        isAuthenticated = tokenManager.accessToken != nil
        if isAuthenticated {
            Task {
                await loadCurrentUser()
            }
        }
    }

    func loadCurrentUser() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let user: User = try await apiClient.request(endpoint: .getCurrentUser)
            currentUser = user
            isAuthenticated = true
        } catch {
            print("loadCurrentUser failed: \(error)")
            logout()
        }
    }

    func logout() {
        tokenManager.clearTokens()
        isAuthenticated = false
        currentUser = nil
    }
}
