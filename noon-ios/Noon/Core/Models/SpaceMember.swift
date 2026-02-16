// SpaceMember.swift
// Noon
// Purpose: Space member model representing users with access to a space

import Foundation

struct SpaceMember: Codable, Identifiable {
    let id: String
    let spaceId: String
    let userId: String
    let role: String
    let joinedAt: Date
}
