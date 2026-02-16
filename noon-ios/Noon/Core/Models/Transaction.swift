// Transaction.swift
// Noon
// Purpose: Transaction model representing financial transactions from API

import Foundation

struct Transaction: Codable, Identifiable {
    let id: String
    let accountId: String
    let amount: Decimal
    let currency: String
    let description: String
    let merchantName: String?
    let date: Date
    let categoryId: String?
    let spaceId: String?
    let isAutoAssigned: Bool
}