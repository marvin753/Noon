// NoonApp.swift
// Noon
// Purpose: Main app entry point and lifecycle management

import SwiftUI

@main
struct NoonApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
