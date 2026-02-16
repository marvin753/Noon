// CategorizationRule.swift
// Noon
// Purpose: Categorization rule model for automatic transaction categorization

import Foundation

struct CategorizationRule: Codable, Identifiable {
    let id: String
    let field: String
    let `operator`: String
    let value: String
    let targetSpaceId: String
    let priority: Int
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case field
        case `operator` = "operator"
        case value
        case targetSpaceId
        case priority
        case isActive
    }
}
