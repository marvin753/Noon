// BalanceCardView.swift
// Noon
// Purpose: Centered balance area with trend badge (renamed from card - no longer a card)

import SwiftUI

struct BalanceAreaView: View {
    let balance: Decimal
    let trendText: String
    let trendType: TrendType

    private var balanceComponents: (euro: String, main: String, cents: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","

        let formattedString = formatter.string(from: NSDecimalNumber(decimal: balance)) ?? "0,00"

        // Split at comma to separate main and cents
        let parts = formattedString.split(separator: ",")
        let mainPart = String(parts.first ?? "0")
        let centsPart = String(parts.last ?? "00")

        return ("€", mainPart, centsPart)
    }

    var body: some View {
        VStack(spacing: 8) {
            // "GUTHABEN" label
            Text("GUTHABEN")
                .overlineStyle()
                .foregroundColor(.textLight)
                .padding(.bottom, 4)

            // Balance number: €2.847,20
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                // € symbol - bold (700)
                Text(balanceComponents.euro)
                    .font(.system(size: 50, weight: .bold))
                    .tracking(-2.5)
                    .foregroundColor(.text)

                // Main digits - light (300)
                Text(balanceComponents.main)
                    .font(.system(size: 50, weight: .light))
                    .tracking(-2.5)
                    .foregroundColor(.text)

                // Comma + cents - light, faint color, smaller size
                Text(",")
                    .font(.system(size: 30, weight: .light))
                    .tracking(-1)
                    .foregroundColor(.textFaint)

                Text(balanceComponents.cents)
                    .font(.system(size: 30, weight: .light))
                    .tracking(-1)
                    .foregroundColor(.textFaint)
            }
            .monospacedDigit()
            .padding(.bottom, 8)

            // Trend badge
            TrendBadge(text: trendText, type: trendType)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack(spacing: 40) {
        BalanceAreaView(
            balance: Decimal(string: "2847.20")!,
            trendText: "+4,2 %",
            trendType: .positive
        )

        BalanceAreaView(
            balance: Decimal(string: "12500.50")!,
            trendText: "-1,3 %",
            trendType: .negative
        )
    }
    .padding()
    .background(Color.bg)
}
