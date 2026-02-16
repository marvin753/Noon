// LoginView.swift
// Noon
// Purpose: User login interface with email/password authentication

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: NoonSpacing.lg) {
            VStack(spacing: NoonSpacing.base) {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, NoonSpacing.base)

            if let error = errorMessage {
                Text(error)
                    .font(.noonCaptionFallback)
                    .foregroundColor(.error)
            }

            NoonButton(title: isLoading ? "Logging in..." : "Login", style: .primary) {
                Task {
                    await login()
                }
            }
            .disabled(isLoading)
            .padding(.horizontal, NoonSpacing.base)
        }
    }

    private func login() async {
        isLoading = true
        errorMessage = nil

        do {
            struct LoginResponse: Decodable {
                let accessToken: String
                let refreshToken: String
            }

            let response: LoginResponse = try await APIClient.shared.request(
                endpoint: .login(email: email, password: password)
            )

            TokenManager.shared.accessToken = response.accessToken
            TokenManager.shared.refreshToken = response.refreshToken

            await appState.loadCurrentUser()
        } catch {
            print("Login error: \(error)")
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
