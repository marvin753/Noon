// BankConnection.swift
// Noon
// Purpose: Bank connection model representing Tink integrations managed by backend

import Foundation

struct BankConnection: Codable, Identifiable {
    let id: String
    let provider: String
    let status: String
    let consentExpiresAt: Date?
    let createdAt: Date
}
