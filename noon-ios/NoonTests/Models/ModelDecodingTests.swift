// ModelDecodingTests.swift
// Noon
// Purpose: Tests for JSON decoding of API response models

import XCTest
@testable import Noon

final class ModelDecodingTests: XCTestCase {
    var decoder: JSONDecoder!

    override func setUpWithError() throws {
        decoder = JSONDecoder()
        // TODO: Configure decoder with date strategy matching backend
    }

    func testUserDecoding() throws {
        // TODO: Test User model JSON decoding
        let json = """
        {
            "id": "test-user-1"
        }
        """.data(using: .utf8)!

        let user = try decoder.decode(User.self, from: json)
        XCTAssertEqual(user.id, "test-user-1")
    }

    // TODO: Add tests for all model types
    // TODO: Add tests for nested models
    // TODO: Add tests for optional fields
}
