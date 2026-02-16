// User.swift
// Noon
// Purpose: User model representing authenticated user data from API

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let createdAt: Date
}
