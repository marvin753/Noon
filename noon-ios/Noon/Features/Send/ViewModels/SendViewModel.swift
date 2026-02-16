// SendViewModel.swift
// Noon
// Purpose: Manages state for sending money flow

import Foundation
import SwiftUI

@MainActor
class SendViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var recipient: String = ""
    @Published var isSending = false
    @Published var errorMessage: String?

    var displayAmount: String {
        if amount.isEmpty {
            return "€0,00"
        }

        // Format amount with German locale
        let cleanedAmount = amount.replacingOccurrences(of: ",", with: ".")
        if let doubleValue = Double(cleanedAmount) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "de_DE")
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2

            if let formatted = formatter.string(from: NSNumber(value: doubleValue)) {
                return "€\(formatted)"
            }
        }

        return "€\(amount)"
    }

    func appendDigit(_ digit: String) {
        // Limit to reasonable amount (max 9 digits before decimal)
        if amount.replacingOccurrences(of: ",", with: "").count >= 11 {
            return
        }
        amount += digit
    }

    func appendDecimalSeparator() {
        if !amount.contains(",") {
            amount += ","
        }
    }

    func deleteLastDigit() {
        if !amount.isEmpty {
            amount.removeLast()
        }
    }

    func clearAmount() {
        amount = ""
    }

    func send() async {
        guard !amount.isEmpty, !recipient.isEmpty else {
            errorMessage = "Bitte Betrag und Empfänger eingeben"
            return
        }

        isSending = true
        errorMessage = nil

        // Placeholder for actual send logic
        // TODO: Implement API call to send money
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay

        isSending = false

        // Reset on success
        amount = ""
        recipient = ""
    }
}
