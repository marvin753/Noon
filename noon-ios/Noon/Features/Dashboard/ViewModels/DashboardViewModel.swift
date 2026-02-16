// DashboardViewModel.swift
// Noon
// Purpose: Manages dashboard data and business logic

import Foundation
import SwiftUI

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var totalBalance: Decimal = 0
    @Published var accounts: [Account] = []
    @Published var recentTransactions: [Transaction] = []
    @Published var spaces: [Space] = []
    @Published var sharedSpaces: [Space] = []
    @Published var isLoading = false
    @Published var error: String?

    private let apiClient = APIClient.shared

    // Computed properties for balance display
    var balanceMain: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        let formattedString = formatter.string(from: NSDecimalNumber(decimal: totalBalance)) ?? "0,00"
        let parts = formattedString.split(separator: ",")
        return String(parts.first ?? "0")
    }

    var balanceCents: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        let formattedString = formatter.string(from: NSDecimalNumber(decimal: totalBalance)) ?? "0,00"
        let parts = formattedString.split(separator: ",")
        return String(parts.last ?? "00")
    }

    var trendPercentage: String {
        // TODO: Calculate actual trend from historical data
        // For now, mock positive trend
        "+4,2 %"
    }

    var trendType: TrendType {
        // TODO: Determine from actual trend calculation
        .positive
    }

    func loadData() async {
        isLoading = true
        error = nil

        do {
            async let accountsTask: [Account] = apiClient.request(endpoint: .getAccounts)
            async let transactionsTask: [Transaction] = apiClient.request(endpoint: .getTransactions)
            async let spacesTask: [Space] = apiClient.request(endpoint: .getSpaces)

            accounts = try await accountsTask
            recentTransactions = try await transactionsTask
            let allSpaces = try await spacesTask

            calculateTotalBalance()
            splitSpaces(allSpaces)
        } catch {
            self.error = error.localizedDescription
            // Fallback to mock data in development
            #if DEBUG
            loadMockData()
            #endif
        }

        isLoading = false
    }

    private func calculateTotalBalance() {
        totalBalance = accounts.reduce(Decimal(0)) { $0 + $1.balance }
    }

    private func splitSpaces(_ allSpaces: [Space]) {
        // TODO: When API supports shared spaces, filter based on members array
        // For now, use simple heuristic: spaces with "Auto" in name are shared
        spaces = allSpaces.filter { !$0.name.lowercased().contains("auto") }
        sharedSpaces = allSpaces.filter { $0.name.lowercased().contains("auto") }
    }

    #if DEBUG
    private func loadMockData() {
        totalBalance = Decimal(string: "2847.20")!
        spaces = [
            Space(
                id: "1",
                name: "Hauptkonto",
                budgetAmount: Decimal(string: "2147.20")!,
                budgetPeriod: "monthly",
                color: "#111111",
                icon: "creditcard",
                createdAt: Date()
            ),
            Space(
                id: "2",
                name: "Urlaub",
                budgetAmount: Decimal(string: "420.00")!,
                budgetPeriod: "yearly",
                color: "#C49332",
                icon: "🏝️",
                createdAt: Date()
            ),
            Space(
                id: "3",
                name: "Essen",
                budgetAmount: Decimal(string: "180.00")!,
                budgetPeriod: "monthly",
                color: "#C45A4A",
                icon: "🍽️",
                createdAt: Date()
            )
        ]
        sharedSpaces = [
            Space(
                id: "4",
                name: "Auto",
                budgetAmount: Decimal(string: "100.00")!,
                budgetPeriod: "shared",
                color: "#A0A0A0",
                icon: "🚗",
                createdAt: Date()
            )
        ]
    }
    #endif
}
