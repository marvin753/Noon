// AuthViewModel.swift
// Noon
// Purpose: Handles authentication logic for login and registration

import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    // TODO: Implement login method
    // TODO: Implement registration method
    // TODO: Implement logout method
    // TODO: Add form validation
    // TODO: Integrate with APIClient and TokenManager
}
