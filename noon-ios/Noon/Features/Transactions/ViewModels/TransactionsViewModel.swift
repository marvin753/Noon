// TransactionsViewModel.swift
// Noon
// Purpose: Manages transaction data fetching, filtering, and categorization

import Foundation
import SwiftUI

@MainActor
class TransactionsViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""

    private let apiClient = APIClient.shared

    func loadTransactions() async {
        isLoading = true
        errorMessage = nil

        do {
            transactions = try await apiClient.request(endpoint: .getTransactions)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            return transactions
        }
        return transactions.filter { transaction in
            transaction.description.localizedCaseInsensitiveContains(searchText) ||
            (transaction.merchantName?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
}
