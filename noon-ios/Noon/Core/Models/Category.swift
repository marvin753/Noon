// Category.swift
// Noon
// Purpose: Transaction category model for organizing expenses and income

import Foundation

struct Category: Codable, Identifiable {
    let id: String
    let name: String
    let icon: String
    let color: String
}
