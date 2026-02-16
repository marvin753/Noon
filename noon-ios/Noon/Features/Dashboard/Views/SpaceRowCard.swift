// SpaceRowCard.swift
// Noon
// Purpose: Full-width card for space display in dashboard

import SwiftUI

struct SpaceRowCard: View {
    let space: Space

    private var iconVariant: SpaceIconVariant {
        // If icon contains emoji, use emoji variant, otherwise symbol
        if space.icon.unicodeScalars.first?.properties.isEmoji == true {
            return .emoji(space.icon, backgroundColor: iconBackgroundColor)
        } else {
            return .symbol(space.icon, backgroundColor: iconBackgroundColor)
        }
    }

    private var iconBackgroundColor: Color {
        // Determine background color based on space name or type
        let lowercaseName = space.name.lowercased()
        if lowercaseName.contains("haupt") || lowercaseName.contains("main") {
            return Color.text.opacity(0.08)
        } else if lowercaseName.contains("urlaub") || lowercaseName.contains("vacation") {
            return .amberBg
        } else if lowercaseName.contains("essen") || lowercaseName.contains("food") {
            return .redBg
        } else {
            return Color(hex: space.color).opacity(0.08)
        }
    }

    private var progressColor: Color {
        let lowercaseName = space.name.lowercased()
        if lowercaseName.contains("haupt") || lowercaseName.contains("main") {
            return .text
        } else if lowercaseName.contains("urlaub") || lowercaseName.contains("vacation") {
            return .amber
        } else if lowercaseName.contains("essen") || lowercaseName.contains("food") {
            return .red
        } else {
            return .text
        }
    }

    private var progress: Double {
        // Mock progress calculation based on budget
        let amount = NSDecimalNumber(decimal: space.budgetAmount).doubleValue
        if space.name.lowercased().contains("haupt") {
            return 0.78
        } else if space.name.lowercased().contains("urlaub") {
            return amount / 1500.0  // Target €1.500
        } else if space.name.lowercased().contains("essen") {
            return amount / 280.0  // Budget €280
        }
        return 0.5
    }

    private var metaText: String {
        let lowercaseName = space.name.lowercased()
        if lowercaseName.contains("haupt") || lowercaseName.contains("main") {
            return "Letzte Buchung · Heute"
        } else if lowercaseName.contains("urlaub") || lowercaseName.contains("vacation") {
            return "Ziel · €1.500"
        } else if lowercaseName.contains("essen") || lowercaseName.contains("food") {
            return "Budget · €280 / Monat"
        }
        return space.budgetPeriod
    }

    private var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        let amountString = formatter.string(from: NSDecimalNumber(decimal: space.budgetAmount)) ?? "0,00"
        return "€\(amountString)"
    }

    private var progressPercentage: String {
        let pct = Int(progress * 100)
        return "\(pct) %"
    }

    var body: some View {
        Button(action: {
            // TODO: Navigate to space detail
        }) {
            NoonCard {
                HStack(spacing: 14) {
                    // Icon
                    SpaceIcon(variant: iconVariant)

                    // Content
                    VStack(alignment: .leading, spacing: 6) {
                        // Name and Amount
                        HStack {
                            Text(space.name)
                                .heading2Style()
                                .foregroundColor(.text)
                            Spacer()
                            Text(formattedAmount)
                                .bodyStyle()
                                .foregroundColor(.text)
                        }

                        // Meta text and percentage
                        HStack {
                            Text(metaText)
                                .captionStyle()
                                .foregroundColor(.textLight)
                            Spacer()
                            Text(progressPercentage)
                                .captionStyle()
                                .foregroundColor(.textLight)
                        }

                        // Progress bar
                        ProgressBar(progress: progress, fillColor: progressColor)
                            .padding(.top, 2)
                    }

                    // Chevron
                    Image(systemName: "chevron.right")
                        .font(.system(size: 7, weight: .semibold))
                        .foregroundColor(.textFaint)
                        .opacity(0.5)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: NoonSpacing.cardGap) {
        SpaceRowCard(space: Space(
            id: "1",
            name: "Hauptkonto",
            budgetAmount: Decimal(string: "2147.20")!,
            budgetPeriod: "monthly",
            color: "#111111",
            icon: "creditcard",
            createdAt: Date()
        ))

        SpaceRowCard(space: Space(
            id: "2",
            name: "Urlaub",
            budgetAmount: Decimal(string: "420.00")!,
            budgetPeriod: "yearly",
            color: "#C49332",
            icon: "🏝️",
            createdAt: Date()
        ))

        SpaceRowCard(space: Space(
            id: "3",
            name: "Essen",
            budgetAmount: Decimal(string: "180.00")!,
            budgetPeriod: "monthly",
            color: "#C45A4A",
            icon: "🍽️",
            createdAt: Date()
        ))
    }
    .padding()
    .background(Color.bg)
}
