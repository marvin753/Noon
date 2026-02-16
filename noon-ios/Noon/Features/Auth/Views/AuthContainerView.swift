// AuthContainerView.swift
// Noon
// Purpose: Container view that switches between login and registration

import SwiftUI

struct AuthContainerView: View {
    @State private var showingLogin = true
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack(spacing: NoonSpacing.xxl) {
                VStack(spacing: NoonSpacing.base) {
                    Text("Noon")
                        .font(.noonTitleFallback)
                        .foregroundColor(.warmDot)

                    Text("Your shared financial space")
                        .font(.noonBodyFallback)
                        .foregroundColor(.textSecondary)
                }
                .padding(.top, NoonSpacing.xxl)

                Picker("Auth Mode", selection: $showingLogin) {
                    Text("Login").tag(true)
                    Text("Register").tag(false)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, NoonSpacing.base)

                if showingLogin {
                    LoginView()
                } else {
                    RegisterView()
                }

                Spacer()
            }
            .background(Color.bg.ignoresSafeArea())
        }
    }
}

#Preview {
    AuthContainerView()
        .environmentObject(AppState())
}
