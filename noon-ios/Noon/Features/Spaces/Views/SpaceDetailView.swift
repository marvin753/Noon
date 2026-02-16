// SpaceDetailView.swift
// Noon
// Purpose: Detailed view for a shared space with members and transactions

import SwiftUI

struct SpaceDetailView: View {
    let space: Space
    @State private var transactions: [Transaction] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NoonSpacing.lg) {
                NoonCard {
                    VStack(alignment: .leading, spacing: NoonSpacing.base) {
                        HStack {
                            Text(space.icon)
                                .font(.system(size: 48))

                            Spacer()

                            Circle()
                                .fill(Color(hex: space.color))
                                .frame(width: 24, height: 24)
                        }

                        Text(space.name)
                            .font(.noonTitleFallback)
                            .foregroundColor(.text)

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Budget")
                                    .font(.noonCaptionFallback)
                                    .foregroundColor(.textSecondary)

                                Text(space.budgetAmount.currencyFormatted())
                                    .font(.noonHeadlineFallback)
                                    .foregroundColor(.text)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 4) {
                                Text("Period")
                                    .font(.noonCaptionFallback)
                                    .foregroundColor(.textSecondary)

                                Text(space.budgetPeriod)
                                    .font(.noonBodyFallback)
                                    .foregroundColor(.text)
                            }
                        }
                    }
                }
                .padding(.horizontal, NoonSpacing.base)

                VStack(alignment: .leading, spacing: NoonSpacing.base) {
                    Text("Transactions")
                        .font(.noonHeadlineFallback)
                        .foregroundColor(.text)
                        .padding(.horizontal, NoonSpacing.base)

                    ForEach(transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(transaction.merchantName ?? transaction.description)
                                    .font(.noonBodyFallback)
                                    .foregroundColor(.text)
                                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.noonCaptionFallback)
                                    .foregroundColor(.textSecondary)
                            }
                            Spacer()
                            Text(transaction.amount.currencyFormatted())
                                .font(.noonBodyFallback)
                                .fontWeight(.medium)
                                .foregroundColor(transaction.amount < 0 ? .text : .green)
                        }
                        .padding(.horizontal, NoonSpacing.base)
                    }

                    if transactions.isEmpty {
                        Text("No transactions assigned to this space yet")
                            .font(.noonBodyFallback)
                            .foregroundColor(.textSecondary)
                            .padding(.horizontal, NoonSpacing.base)
                    }
                }
            }
            .padding(.vertical, NoonSpacing.base)
        }
        .background(Color.bg)
        .navigationTitle(space.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        SpaceDetailView(space: .preview)
    }
}
