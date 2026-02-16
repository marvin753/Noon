// TransactionDetailView.swift
// Noon
// Purpose: Detailed view for a single transaction with category management

import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        ScrollView {
            VStack(spacing: NoonSpacing.lg) {
                NoonCard {
                    VStack(spacing: NoonSpacing.base) {
                        HStack {
                            Text(transaction.amount.currencyFormatted())
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(transaction.amount < 0 ? .error : .success)

                            Text(transaction.currency)
                                .font(.noonHeadlineFallback)
                                .foregroundColor(.textSecondary)
                        }

                        if let merchant = transaction.merchantName {
                            Text(merchant)
                                .font(.noonHeadlineFallback)
                                .foregroundColor(.text)
                        }

                        Text(transaction.description)
                            .font(.noonBodyFallback)
                            .foregroundColor(.textSecondary)
                    }
                }
                .padding(.horizontal, NoonSpacing.base)

                VStack(spacing: NoonSpacing.base) {
                    DetailRow(label: "Date", value: transaction.date.formatted(date: .long, time: .omitted))
                    DetailRow(label: "Account ID", value: transaction.accountId)

                    if transaction.isAutoAssigned {
                        HStack {
                            Text("Auto-assigned")
                                .font(.noonBodyFallback)
                                .foregroundColor(.textSecondary)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.accent)
                        }
                        .padding(.horizontal, NoonSpacing.base)
                    }
                }
            }
            .padding(.vertical, NoonSpacing.base)
        }
        .background(Color.bg)
        .navigationTitle("Transaction Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.noonBodyFallback)
                .foregroundColor(.textSecondary)
            Spacer()
            Text(value)
                .font(.noonBodyFallback)
                .foregroundColor(.text)
        }
        .padding(.horizontal, NoonSpacing.base)
    }
}

#Preview {
    NavigationView {
        TransactionDetailView(transaction: .preview)
    }
}
