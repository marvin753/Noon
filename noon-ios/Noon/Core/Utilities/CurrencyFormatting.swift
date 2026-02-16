// CurrencyFormatting.swift
// Noon
// Purpose: Currency formatting utilities for German locale display

import Foundation

struct NoonCurrencyFormatter {
    /// Formats a Decimal as German currency: €2.847,20
    static func format(_ amount: Decimal, showSign: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "de_DE")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: amount as NSDecimalNumber) ?? "0,00"

        if showSign && amount > 0 {
            return "+€\(formatted)"
        }
        return "€\(formatted)"
    }

    /// Splits formatted amount into main part and cents for display styling
    /// Returns (mainPart: "€2.847", centsPart: ",20")
    static func splitAmount(_ amount: Decimal) -> (main: String, cents: String) {
        let formatted = format(amount)
        if let commaIndex = formatted.lastIndex(of: ",") {
            let main = String(formatted[formatted.startIndex..<commaIndex])
            let cents = String(formatted[commaIndex...])
            return (main, cents)
        }
        return (formatted, ",00")
    }

    /// Format percentage: "28 %" or "+4,2 %"
    static func formatPercent(_ value: Double, showSign: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0"
        let sign = showSign && value > 0 ? "+" : ""
        return "\(sign)\(formatted) %"
    }
}

// MARK: - Decimal Extension

extension Decimal {
    /// Convenience method for German currency formatting
    func currencyFormatted(showSign: Bool = false) -> String {
        NoonCurrencyFormatter.format(self, showSign: showSign)
    }

    /// Splits amount into main and cents parts
    var currencySplit: (main: String, cents: String) {
        NoonCurrencyFormatter.splitAmount(self)
    }
}
