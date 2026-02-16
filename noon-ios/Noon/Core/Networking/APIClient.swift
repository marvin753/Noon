// APIClient.swift
// Noon
// Purpose: Core networking client for all API communication with backend

import Foundation

@MainActor
class APIClient {
    static let shared = APIClient()

    private let baseURL: URL
    private let session: URLSession
    private let tokenManager = TokenManager.shared
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    weak var appState: AppState?

    init(baseURL: String = Configuration.apiBaseURL) {
        self.baseURL = URL(string: baseURL)!
        self.session = URLSession.shared

        self.decoder = JSONDecoder()
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self.decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = isoFormatter.date(from: dateString) {
                return date
            }
            // Fallback for dates without fractional seconds
            let basicFormatter = ISO8601DateFormatter()
            basicFormatter.formatOptions = [.withInternetDateTime]
            if let date = basicFormatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Cannot decode date: \(dateString)"))
        }
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase

        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
    }

    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        let request = try buildRequest(endpoint: endpoint)

        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response)
            return try decoder.decode(T.self, from: data)
        } catch let error as APIError where error.isUnauthorized {
            // Attempt to refresh token
            if try await refreshAccessToken() {
                // Retry original request with new token
                let retryRequest = try buildRequest(endpoint: endpoint)
                let (data, response) = try await session.data(for: retryRequest)
                try validateResponse(response)
                return try decoder.decode(T.self, from: data)
            } else {
                // Refresh failed, log out user
                appState?.logout()
                throw APIError.unauthorized
            }
        } catch {
            throw mapError(error)
        }
    }

    func requestWithoutResponse(endpoint: APIEndpoint) async throws {
        let request = try buildRequest(endpoint: endpoint)

        do {
            let (_, response) = try await session.data(for: request)
            try validateResponse(response)
        } catch let error as APIError where error.isUnauthorized {
            if try await refreshAccessToken() {
                let retryRequest = try buildRequest(endpoint: endpoint)
                let (_, response) = try await session.data(for: retryRequest)
                try validateResponse(response)
            } else {
                appState?.logout()
                throw APIError.unauthorized
            }
        } catch {
            throw mapError(error)
        }
    }

    private func buildRequest(endpoint: APIEndpoint) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Add authorization header if token exists
        if let accessToken = tokenManager.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        // Encode body if present
        if let body = endpoint.body {
            request.httpBody = try encoder.encode(AnyEncodable(body))
        }

        return request
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }

        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 400:
            throw APIError.validationError("Invalid request")
        case 500...599:
            throw APIError.serverError
        default:
            throw APIError.unknown
        }
    }

    private func refreshAccessToken() async throws -> Bool {
        guard let refreshToken = tokenManager.refreshToken else {
            return false
        }

        struct RefreshBody: Encodable {
            let refreshToken: String
        }

        struct RefreshResponse: Decodable {
            let accessToken: String
        }

        do {
            let url = baseURL.appendingPathComponent("/auth/refresh")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(RefreshBody(refreshToken: refreshToken))

            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return false
            }

            let refreshResponse = try decoder.decode(RefreshResponse.self, from: data)
            tokenManager.accessToken = refreshResponse.accessToken
            return true
        } catch {
            return false
        }
    }

    private func mapError(_ error: Error) -> APIError {
        if let apiError = error as? APIError {
            return apiError
        }

        if let decodingError = error as? DecodingError {
            return .decodingError(decodingError)
        }

        if let urlError = error as? URLError {
            return .networkError(urlError)
        }

        return .unknown
    }
}

// Helper for type erasure of Encodable
private struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void

    init<T: Encodable>(_ value: T) {
        encodeClosure = { encoder in
            try value.encode(to: encoder)
        }
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}

private extension APIError {
    var isUnauthorized: Bool {
        if case .unauthorized = self {
            return true
        }
        return false
    }
}
