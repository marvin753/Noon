// CategorizationViewModel.swift
// Noon
// Purpose: Manages categorization rules and automatic categorization logic

import Foundation
import SwiftUI

@MainActor
class CategorizationViewModel: ObservableObject {
    @Published var rules: [CategorizationRule] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false

    // TODO: Implement rule fetching
    // TODO: Add rule creation/update/delete
    // TODO: Add rule application to transactions
    // TODO: Add category management
}
