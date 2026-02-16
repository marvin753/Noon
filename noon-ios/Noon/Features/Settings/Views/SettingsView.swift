// SettingsView.swift
// Noon
// Purpose: App settings and user profile management

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Custom top bar - "Profil" heading
                HStack {
                    Text("Profil")
                        .font(.system(size: 23, weight: .bold))
                        .tracking(-0.6)
                        .foregroundColor(.text)
                    Spacer()
                }
                .padding(.horizontal, NoonSpacing.topBarPadding)
                .padding(.top, 6)
                .padding(.bottom, 24)

                // User avatar/initial circle
                VStack(spacing: 8) {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Text(String((appState.currentUser?.name ?? "?").prefix(1)))
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        )

                    Text(appState.currentUser?.name ?? "")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.text)

                    Text(appState.currentUser?.email ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.textLight)
                }
                .padding(.bottom, 28)

                // Settings sections - card-based groups
                VStack(spacing: NoonSpacing.md) {

                    // KONTO section
                    SectionLabel(text: "Konto")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    NoonCard {
                        VStack(spacing: 0) {
                            settingsRow(icon: "person", label: "Persönliche Daten")
                            Divider().background(Color.divider)
                            settingsRow(icon: "lock", label: "Sicherheit")
                            Divider().background(Color.divider)
                            settingsRow(icon: "creditcard", label: "Zahlungsmethoden")
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)

                    // VERBINDUNGEN section
                    SectionLabel(text: "Verbindungen")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    NoonCard {
                        VStack(spacing: 0) {
                            settingsRow(icon: "building.columns", label: "Verbundene Banken")
                            Divider().background(Color.divider)
                            settingsRow(icon: "rectangle.stack", label: "Konten verwalten")
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)

                    // EINSTELLUNGEN section
                    SectionLabel(text: "Einstellungen")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    NoonCard {
                        VStack(spacing: 0) {
                            settingsToggleRow(icon: "bell", label: "Benachrichtigungen", isOn: .constant(true))
                            Divider().background(Color.divider)
                            settingsToggleRow(icon: "faceid", label: "Face ID", isOn: .constant(false))
                            Divider().background(Color.divider)
                            settingsRow(icon: "moon", label: "Erscheinungsbild")
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)

                    // INFO section
                    SectionLabel(text: "Info")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    NoonCard {
                        VStack(spacing: 0) {
                            settingsRow(icon: "questionmark.circle", label: "Hilfe & Support")
                            Divider().background(Color.divider)
                            settingsRow(icon: "doc.text", label: "Datenschutz")
                            Divider().background(Color.divider)
                            settingsValueRow(label: "Version", value: "1.0.0")
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)

                    // Logout button - ghost style, NOT destructive red
                    Button {
                        appState.logout()
                    } label: {
                        Text("Abmelden")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.textLight)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, 40)
                }
            }
            .padding(.bottom, 86)
        }
        .background(Color.bg)
    }

    // MARK: - Helper Views

    private func settingsRow(icon: String, label: String) -> some View {
        Button {
            // Navigation action will be implemented later
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.textLight)
                    .frame(width: 20, height: 20)

                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.text)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.textFaint)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func settingsToggleRow(icon: String, label: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.textLight)
                .frame(width: 20, height: 20)

            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.text)

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(.accent)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }

    private func settingsValueRow(label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.text)

            Spacer()

            Text(value)
                .font(.system(size: 13))
                .foregroundColor(.textLight)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
