// RuleListView.swift
// Noon
// Purpose: List view displaying auto-categorization rules

import SwiftUI

struct RuleListView: View {
    @StateObject private var viewModel = CategorizationViewModel()

    var body: some View {
        Text("RuleListView")
        // TODO: Implement rule list
        // TODO: Add rule priority ordering
        // TODO: Add enable/disable toggle
        // TODO: Add navigation to create/edit rule
    }
}

#Preview {
    RuleListView()
}
