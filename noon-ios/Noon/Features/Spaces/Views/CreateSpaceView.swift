// CreateSpaceView.swift
// Noon
// Purpose: Form for creating a new shared financial space

import SwiftUI

struct CreateSpaceView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SpacesViewModel()

    @State private var name = ""
    @State private var budgetAmount = ""
    @State private var budgetPeriod = "monthly"
    @State private var selectedColor = "#4CAF50"
    @State private var selectedIcon = "🛒"

    let budgetPeriods = ["daily", "weekly", "monthly", "yearly"]
    let colorOptions = ["#4CAF50", "#FF6B4A", "#2196F3", "#9C27B0", "#FF9800"]
    let iconOptions = ["🛒", "🎬", "🚗", "🏠", "✈️", "🍽️", "💪", "🎓"]

    var body: some View {
        NavigationView {
            Form {
                Section("Basic Information") {
                    TextField("Space Name", text: $name)

                    HStack {
                        Text("Icon")
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: NoonSpacing.sm) {
                                ForEach(iconOptions, id: \.self) { icon in
                                    Button {
                                        selectedIcon = icon
                                    } label: {
                                        Text(icon)
                                            .font(.system(size: 32))
                                            .padding(NoonSpacing.sm)
                                            .background(selectedIcon == icon ? Color.accent.opacity(0.2) : Color.clear)
                                            .cornerRadius(NoonSpacing.radiusSmall)
                                    }
                                }
                            }
                        }
                    }

                    HStack {
                        Text("Color")
                        Spacer()
                        HStack(spacing: NoonSpacing.sm) {
                            ForEach(colorOptions, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    Circle()
                                        .fill(Color(hex: color))
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: selectedColor == color ? 2 : 0)
                                        )
                                }
                            }
                        }
                    }
                }

                Section("Budget") {
                    TextField("Budget Amount", text: $budgetAmount)
                        .keyboardType(.decimalPad)

                    Picker("Budget Period", selection: $budgetPeriod) {
                        ForEach(budgetPeriods, id: \.self) { period in
                            Text(period.capitalized).tag(period)
                        }
                    }
                }
            }
            .navigationTitle("Create Space")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        Task {
                            await createSpace()
                        }
                    }
                    .disabled(name.isEmpty || budgetAmount.isEmpty)
                }
            }
        }
    }

    private func createSpace() async {
        guard let amount = Decimal(string: budgetAmount) else { return }

        await viewModel.createSpace(
            name: name,
            budgetAmount: amount,
            budgetPeriod: budgetPeriod,
            color: selectedColor,
            icon: selectedIcon
        )

        if viewModel.errorMessage == nil {
            dismiss()
        }
    }
}

#Preview {
    CreateSpaceView()
}
