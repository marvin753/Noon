// Space.swift
// Noon
// Purpose: Shared financial space model for collaborative budgeting

import Foundation

struct Space: Codable, Identifiable {
    let id: String
    let name: String
    let budgetAmount: Decimal
    let budgetPeriod: String
    let color: String
    let icon: String
    let createdAt: Date
}
