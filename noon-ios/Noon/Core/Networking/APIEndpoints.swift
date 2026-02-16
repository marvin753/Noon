// APIEndpoints.swift
// Noon
// Purpose: Defines all API endpoint paths and URL construction

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    let body: Encodable?

    // Auth
    static func register(email: String, password: String, name: String) -> APIEndpoint {
        struct Body: Encodable {
            let email: String
            let password: String
            let name: String
        }
        return APIEndpoint(path: "/auth/register", method: .post, body: Body(email: email, password: password, name: name))
    }

    static func login(email: String, password: String) -> APIEndpoint {
        struct Body: Encodable {
            let email: String
            let password: String
        }
        return APIEndpoint(path: "/auth/login", method: .post, body: Body(email: email, password: password))
    }

    static let refreshToken = APIEndpoint(path: "/auth/refresh", method: .post, body: nil as String?)

    // User
    static let getCurrentUser = APIEndpoint(path: "/users/me", method: .get, body: nil as String?)

    static func updateUser(name: String) -> APIEndpoint {
        struct Body: Encodable {
            let name: String
        }
        return APIEndpoint(path: "/users/me", method: .patch, body: Body(name: name))
    }

    // Connections
    static let createConnection = APIEndpoint(path: "/connections", method: .post, body: nil as String?)
    static let getConnections = APIEndpoint(path: "/connections", method: .get, body: nil as String?)

    static func connectionCallback(code: String) -> APIEndpoint {
        struct Body: Encodable {
            let code: String
        }
        return APIEndpoint(path: "/connections/callback", method: .post, body: Body(code: code))
    }

    // Accounts
    static let getAccounts = APIEndpoint(path: "/accounts", method: .get, body: nil as String?)

    static func getAccount(id: String) -> APIEndpoint {
        APIEndpoint(path: "/accounts/\(id)", method: .get, body: nil as String?)
    }

    // Transactions
    static let getTransactions = APIEndpoint(path: "/transactions", method: .get, body: nil as String?)

    static func getTransaction(id: String) -> APIEndpoint {
        APIEndpoint(path: "/transactions/\(id)", method: .get, body: nil as String?)
    }

    // Spaces
    static let getSpaces = APIEndpoint(path: "/spaces", method: .get, body: nil as String?)

    static func createSpace(name: String, budgetAmount: Decimal, budgetPeriod: String, color: String, icon: String) -> APIEndpoint {
        struct Body: Encodable {
            let name: String
            let budgetAmount: Decimal
            let budgetPeriod: String
            let color: String
            let icon: String
        }
        return APIEndpoint(path: "/spaces", method: .post, body: Body(name: name, budgetAmount: budgetAmount, budgetPeriod: budgetPeriod, color: color, icon: icon))
    }

    static func getSpace(id: String) -> APIEndpoint {
        APIEndpoint(path: "/spaces/\(id)", method: .get, body: nil as String?)
    }

    static func updateSpace(id: String, name: String?, budgetAmount: Decimal?, budgetPeriod: String?) -> APIEndpoint {
        struct Body: Encodable {
            let name: String?
            let budgetAmount: Decimal?
            let budgetPeriod: String?
        }
        return APIEndpoint(path: "/spaces/\(id)", method: .patch, body: Body(name: name, budgetAmount: budgetAmount, budgetPeriod: budgetPeriod))
    }

    static func deleteSpace(id: String) -> APIEndpoint {
        APIEndpoint(path: "/spaces/\(id)", method: .delete, body: nil as String?)
    }

    static func assignTransactionToSpace(spaceId: String, transactionId: String) -> APIEndpoint {
        struct Body: Encodable {
            let transactionId: String
        }
        return APIEndpoint(path: "/spaces/\(spaceId)/assign", method: .post, body: Body(transactionId: transactionId))
    }

    // Rules
    static let getRules = APIEndpoint(path: "/rules", method: .get, body: nil as String?)

    static func createRule(field: String, operator_: String, value: String, targetSpaceId: String, priority: Int) -> APIEndpoint {
        struct Body: Encodable {
            let field: String
            let `operator`: String
            let value: String
            let targetSpaceId: String
            let priority: Int
        }
        return APIEndpoint(path: "/rules", method: .post, body: Body(field: field, operator: operator_, value: value, targetSpaceId: targetSpaceId, priority: priority))
    }

    static func getRule(id: String) -> APIEndpoint {
        APIEndpoint(path: "/rules/\(id)", method: .get, body: nil as String?)
    }

    static func updateRule(id: String, field: String?, operator_: String?, value: String?, targetSpaceId: String?, priority: Int?, isActive: Bool?) -> APIEndpoint {
        struct Body: Encodable {
            let field: String?
            let `operator`: String?
            let value: String?
            let targetSpaceId: String?
            let priority: Int?
            let isActive: Bool?
        }
        return APIEndpoint(path: "/rules/\(id)", method: .patch, body: Body(field: field, operator: operator_, value: value, targetSpaceId: targetSpaceId, priority: priority, isActive: isActive))
    }

    static func deleteRule(id: String) -> APIEndpoint {
        APIEndpoint(path: "/rules/\(id)", method: .delete, body: nil as String?)
    }

    // Sharing
    static func inviteToSpace(spaceId: String, email: String, role: String) -> APIEndpoint {
        struct Body: Encodable {
            let spaceId: String
            let email: String
            let role: String
        }
        return APIEndpoint(path: "/sharing/invite", method: .post, body: Body(spaceId: spaceId, email: email, role: role))
    }

    static let getSharedSpaces = APIEndpoint(path: "/sharing/spaces", method: .get, body: nil as String?)
}
