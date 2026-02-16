// Configuration.swift
// Noon
// Purpose: App configuration and environment variables from xcconfig

import Foundation

struct Configuration {
    static let apiBaseURL: String = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            return "http://localhost:3002"
        }
        return urlString
    }()

    static let tinkLinkURL: String = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "TINK_LINK_URL") as? String else {
            return "https://link.tink.com"
        }
        return urlString
    }()

    // TODO: Add additional configuration values as needed
}
