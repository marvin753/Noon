// AccountListView.swift
// Noon
// Purpose: List view displaying all connected bank accounts

import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel = AccountsViewModel()

    var body: some View {
        Text("AccountListView")
        // TODO: Implement account list with SwiftUI List
        // TODO: Add account grouping by institution
        // TODO: Add pull-to-refresh
        // TODO: Add navigation to account detail
    }
}

#Preview {
    AccountListView()
}
