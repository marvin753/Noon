// Account.swift
// Noon
// Purpose: Bank account model representing connected accounts from API

import Foundation

struct Account: Codable, Identifiable {
    let id: String
    let bankConnectionId: String
    let name: String
    let iban: String
    let balance: Decimal
    let currency: String
    let type: String
    let lastSyncedAt: Date?
}