// TransactionFilterView.swift
// Noon
// Purpose: Filter sheet for transactions by date, category, amount, etc.

import SwiftUI

struct TransactionFilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var minAmount = ""
    @State private var maxAmount = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Date Range") {
                    DatePicker("From", selection: $startDate, displayedComponents: .date)
                    DatePicker("To", selection: $endDate, displayedComponents: .date)
                }

                Section("Amount Range") {
                    TextField("Minimum Amount", text: $minAmount)
                        .keyboardType(.decimalPad)

                    TextField("Maximum Amount", text: $maxAmount)
                        .keyboardType(.decimalPad)
                }

                Section("Transaction Type") {
                    Toggle("Income", isOn: .constant(true))
                    Toggle("Expenses", isOn: .constant(true))
                }
            }
            .navigationTitle("Filter Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    Button("Reset Filters") {
                        // Reset all filters
                    }
                    .foregroundColor(.accent)
                }
            }
        }
    }
}

#Preview {
    TransactionFilterView()
}
