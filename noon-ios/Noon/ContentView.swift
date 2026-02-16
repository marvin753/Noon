// ContentView.swift
// Noon
// Purpose: Root view that handles navigation between authenticated and unauthenticated states

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isAuthenticated {
                MainTabView()
            } else {
                AuthContainerView()
            }
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: NoonTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // Content area - switches based on selectedTab
            Group {
                switch selectedTab {
                case .home:
                    DashboardView()
                case .activity:
                    TransactionListView()
                case .send:
                    SendView()
                case .profile:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom tab bar overlay at bottom
            NoonTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Tab Definition
enum NoonTab: CaseIterable {
    case home
    case activity
    case send
    case profile

    var iconName: String {
        switch self {
        case .home: return "house"
        case .activity: return "waveform.path.ecg"
        case .send: return "arrow.down"
        case .profile: return "person"
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .activity: return "Aktivität"
        case .send: return "Senden"
        case .profile: return "Profil"
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
