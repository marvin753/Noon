// APIError.swift
// Noon
// Purpose: Typed errors for API communication and error handling

import Foundation

enum APIError: LocalizedError {
    case unauthorized
    case forbidden
    case notFound
    case validationError(String)
    case serverError
    case networkError(Error)
    case decodingError(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Authentication required. Please log in again."
        case .forbidden:
            return "You don't have permission to access this resource."
        case .notFound:
            return "The requested resource was not found."
        case .validationError(let message):
            return "Validation error: \(message)"
        case .serverError:
            return "A server error occurred. Please try again later."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
