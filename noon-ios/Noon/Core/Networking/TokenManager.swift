// TokenManager.swift
// Noon
// Purpose: Secure storage and management of authentication tokens using Keychain with in-memory fallback

import Foundation
import KeychainAccess

class TokenManager {
    static let shared = TokenManager()

    private let keychain = Keychain(service: "com.noon.app")
    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"

    // In-memory cache — primary storage, Keychain is persistence backup
    private var _accessToken: String?
    private var _refreshToken: String?

    private init() {
        // Load from Keychain on startup if available
        _accessToken = try? keychain.get(accessTokenKey)
        _refreshToken = try? keychain.get(refreshTokenKey)
    }

    var accessToken: String? {
        get {
            _accessToken
        }
        set {
            _accessToken = newValue
            if let token = newValue {
                try? keychain.set(token, key: accessTokenKey)
            } else {
                try? keychain.remove(accessTokenKey)
            }
        }
    }

    var refreshToken: String? {
        get {
            _refreshToken
        }
        set {
            _refreshToken = newValue
            if let token = newValue {
                try? keychain.set(token, key: refreshTokenKey)
            } else {
                try? keychain.remove(refreshTokenKey)
            }
        }
    }

    func clearTokens() {
        _accessToken = nil
        _refreshToken = nil
        try? keychain.remove(accessTokenKey)
        try? keychain.remove(refreshTokenKey)
    }
}
