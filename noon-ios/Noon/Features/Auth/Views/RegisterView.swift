// RegisterView.swift
// Noon
// Purpose: User registration interface for new accounts

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: NoonSpacing.lg) {
            VStack(spacing: NoonSpacing.base) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)

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

            NoonButton(title: isLoading ? "Creating Account..." : "Register", style: .primary) {
                Task {
                    await register()
                }
            }
            .disabled(isLoading)
            .padding(.horizontal, NoonSpacing.base)
        }
    }

    private func register() async {
        isLoading = true
        errorMessage = nil

        do {
            struct RegisterResponse: Decodable {
                let accessToken: String
                let refreshToken: String
            }

            let response: RegisterResponse = try await APIClient.shared.request(
                endpoint: .register(email: email, password: password, name: name)
            )

            TokenManager.shared.accessToken = response.accessToken
            TokenManager.shared.refreshToken = response.refreshToken

            await appState.loadCurrentUser()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppState())
}
