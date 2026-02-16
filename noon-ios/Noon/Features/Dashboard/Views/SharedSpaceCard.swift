// SharedSpaceCard.swift
// Noon
// Purpose: Card for shared spaces showing avatar stack of members

import SwiftUI

struct SharedSpaceCard: View {
    let space: Space

    private var iconVariant: SpaceIconVariant {
        if space.icon.unicodeScalars.first?.properties.isEmoji == true {
            return .emoji(space.icon, backgroundColor: Color.textLight.opacity(0.08))
        } else {
            return .symbol(space.icon, backgroundColor: Color.textLight.opacity(0.08))
        }
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

    private var progress: Double {
        // Mock progress for shared spaces
        0.4
    }

    private var progressPercentage: String {
        let pct = Int(progress * 100)
        return "\(pct) %"
    }

    var body: some View {
        Button(action: {
            // TODO: Navigate to shared space detail
        }) {
            NoonCard {
                HStack(spacing: 14) {
                    // Icon
                    SpaceIcon(variant: iconVariant)

                    // Content
                    VStack(alignment: .leading, spacing: 6) {
                        // Name, Avatar Stack, and Amount
                        HStack(spacing: 6) {
                            Text(space.name)
                                .heading2Style()
                                .foregroundColor(.text)

                            AvatarStack(initials: ["M", "T"])

                            Spacer()

                            Text(formattedAmount)
                                .bodyStyle()
                                .foregroundColor(.text)
                        }

                        // Meta text (shared with) and percentage
                        HStack {
                            Text("mit Tim")
                                .captionStyle()
                                .foregroundColor(.textLight)
                            Spacer()
                            Text(progressPercentage)
                                .captionStyle()
                                .foregroundColor(.textLight)
                        }

                        // Progress bar
                        ProgressBar(progress: progress, fillColor: .textLight)
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
    SharedSpaceCard(space: Space(
        id: "4",
        name: "Auto",
        budgetAmount: Decimal(string: "100.00")!,
        budgetPeriod: "shared",
        color: "#A0A0A0",
        icon: "🚗",
        createdAt: Date()
    ))
    .padding()
    .background(Color.bg)
}
