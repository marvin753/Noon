// TransactionListView.swift
// Noon
// Purpose: Aktivität tab - brand-styled transaction list with date grouping

import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewModel = TransactionsViewModel()
    @State private var searchText = ""
    @State private var showingFilters = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Custom top bar
                HStack {
                    Text("Aktivität")
                        .font(.noonHeading1)
                        .tracking(-0.6)
                        .foregroundColor(.text)
                    Spacer()
                    Button {
                        showingFilters = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 20))
                            .foregroundColor(.textLight)
                    }
                }
                .padding(.horizontal, NoonSpacing.topBarPadding)
                .padding(.top, 6)
                .padding(.bottom, 20)

                // Search bar
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.textFaint)
                        .font(.system(size: 16))
                    TextField("Transaktionen suchen", text: $searchText)
                        .font(.system(size: 15))
                        .foregroundColor(.text)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.surface)
                .cornerRadius(NoonSpacing.radiusButton)
                .overlay(
                    RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                        .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                )
                .padding(.horizontal, NoonSpacing.lg)
                .padding(.bottom, 24)

                // Transaction groups
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 60)
                } else if filteredTransactions.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 48))
                            .foregroundColor(.textFaint)
                        Text("Keine Transaktionen")
                            .font(.noonHeading2)
                            .foregroundColor(.textMid)
                    }
                    .padding(.top, 80)
                } else {
                    ForEach(groupedTransactions.keys.sorted(by: >), id: \.self) { section in
                        VStack(alignment: .leading, spacing: NoonSpacing.md) {
                            SectionLabel(text: sectionTitle(for: section))
                                .padding(.horizontal, NoonSpacing.xl)

                            VStack(spacing: NoonSpacing.cardGap) {
                                ForEach(groupedTransactions[section] ?? []) { transaction in
                                    TransactionCardRow(transaction: transaction)
                                }
                            }
                            .padding(.horizontal, NoonSpacing.lg)
                        }
                        .padding(.bottom, NoonSpacing.sectionSpacing)
                    }
                }
            }
            .padding(.bottom, 86) // Tab bar space
        }
        .background(Color.bg)
        .task {
            await viewModel.loadTransactions()
        }
        .refreshable {
            await viewModel.loadTransactions()
        }
        .sheet(isPresented: $showingFilters) {
            TransactionFilterView()
        }
    }

    // MARK: - Computed Properties

    private var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            return viewModel.transactions
        }
        return viewModel.transactions.filter { transaction in
            transaction.description.localizedCaseInsensitiveContains(searchText) ||
            (transaction.merchantName?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    private var groupedTransactions: [Date: [Transaction]] {
        Dictionary(grouping: filteredTransactions) { transaction in
            Calendar.current.startOfDay(for: transaction.date)
        }
    }

    private func sectionTitle(for date: Date) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let transactionDay = calendar.startOfDay(for: date)

        if calendar.isDateInToday(transactionDay) {
            return "HEUTE"
        } else if calendar.isDateInYesterday(transactionDay) {
            return "GESTERN"
        } else if let daysAgo = calendar.dateComponents([.day], from: transactionDay, to: today).day,
                  daysAgo <= 7 {
            return "DIESE WOCHE"
        } else if let weeksAgo = calendar.dateComponents([.weekOfYear], from: transactionDay, to: today).weekOfYear,
                  weeksAgo == 1 {
            return "LETZTE WOCHE"
        } else if calendar.isDate(transactionDay, equalTo: today, toGranularity: .month) {
            return "DIESER MONAT"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM YYYY"
            formatter.locale = Locale(identifier: "de_DE")
            return formatter.string(from: date).uppercased()
        }
    }
}

// MARK: - Transaction Card Row

struct TransactionCardRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 14) {
            // Category icon
            ZStack {
                RoundedRectangle(cornerRadius: NoonSpacing.radiusIcon)
                    .fill(categoryBackgroundColor)
                    .frame(width: 44, height: 44)

                Text(categoryEmoji)
                    .font(.system(size: 20))
            }

            // Transaction details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.merchantName ?? transaction.description)
                    .font(.noonHeading2)
                    .tracking(-0.2)
                    .foregroundColor(.text)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Text(transaction.description)
                        .font(.noonCaption)
                        .foregroundColor(.textLight)
                        .lineLimit(1)

                    if transaction.isAutoAssigned {
                        Circle()
                            .fill(Color.textFaint)
                            .frame(width: 3, height: 3)

                        Text("Auto")
                            .font(.noonCaption)
                            .foregroundColor(.textFaint)
                    }
                }
            }

            Spacer()

            // Amount
            VStack(alignment: .trailing, spacing: 2) {
                Text(formattedAmount)
                    .font(.noonBody)
                    .tracking(-0.5)
                    .monospacedDigit()
                    .foregroundColor(transaction.amount < 0 ? .red : .green)

                Text(relativeDateString)
                    .font(.noonCaption)
                    .foregroundColor(.textLight)
            }
        }
        .padding(.horizontal, NoonSpacing.lg)
        .padding(.vertical, 16)
        .background(Color.surface)
        .cornerRadius(NoonSpacing.radiusCard)
        .overlay(
            RoundedRectangle(cornerRadius: NoonSpacing.radiusCard)
                .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.02), radius: 0.5, x: 0, y: 0.5)
        .shadow(color: Color.black.opacity(0.02), radius: 1.5, x: 0, y: 1)
        .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
    }

    // MARK: - Computed Properties

    private var formattedAmount: String {
        let absAmount = transaction.amount < 0 ? -transaction.amount : transaction.amount
        let sign = transaction.amount >= 0 ? "+" : "−"
        return "\(sign)\(NoonCurrencyFormatter.format(absAmount))"
    }

    private var relativeDateString: String {
        let calendar = Calendar.current
        let now = Date()

        if calendar.isDateInToday(transaction.date) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "de_DE")
            return formatter.string(from: transaction.date)
        } else if let daysAgo = calendar.dateComponents([.day], from: calendar.startOfDay(for: transaction.date), to: calendar.startOfDay(for: now)).day {
            if daysAgo == 1 {
                return "Gestern"
            } else if daysAgo <= 7 {
                return "\(daysAgo)d"
            }
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM."
        formatter.locale = Locale(identifier: "de_DE")
        return formatter.string(from: transaction.date)
    }

    private var categoryEmoji: String {
        // Map common category IDs to emojis
        guard let categoryId = transaction.categoryId else { return "💳" }

        switch categoryId.lowercased() {
        case "food", "groceries", "cat-food":
            return "🛒"
        case "restaurant", "dining":
            return "🍽️"
        case "transport", "travel":
            return "🚗"
        case "entertainment":
            return "🎬"
        case "shopping":
            return "🛍️"
        case "health":
            return "⚕️"
        case "bills", "utilities":
            return "📄"
        case "income", "salary":
            return "💰"
        default:
            return "💳"
        }
    }

    private var categoryBackgroundColor: Color {
        if transaction.amount >= 0 {
            return Color.greenBg
        } else {
            return Color.black.opacity(0.03)
        }
    }
}

#Preview {
    TransactionListView()
}
