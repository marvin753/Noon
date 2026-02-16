// AccountsViewModel.swift
// Noon
// Purpose: Manages account data fetching and bank connection flow

import Foundation
import SwiftUI

@MainActor
class AccountsViewModel: ObservableObject {
    @Published var accounts: [Account] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // TODO: Implement account fetching from API
    // TODO: Add bank connection initiation
    // TODO: Add account refresh/sync
    // TODO: Integrate with local AccountStore
}
