// SharingViewModel.swift
// Noon
// Purpose: Manages space sharing and member invitation logic

import Foundation
import SwiftUI

@MainActor
class SharingViewModel: ObservableObject {
    @Published var sharedSpaces: [Space] = []
    @Published var pendingInvitations: [Space] = []
    @Published var isLoading = false

    // TODO: Implement invitation sending
    // TODO: Add invitation acceptance/decline
    // TODO: Add member removal
    // TODO: Add permission management
}
