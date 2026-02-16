// PreviewData.swift
// Noon
// Purpose: Mock data for SwiftUI previews

import Foundation

#if DEBUG
extension User {
    static let preview = User(
        id: "preview-user-1",
        email: "max@example.com",
        name: "Max Mustermann",
        createdAt: Date()
    )
}

extension Account {
    static let preview = Account(
        id: "preview-account-1",
        bankConnectionId: "conn-1",
        name: "Hauptkonto",
        iban: "DE89370400440532013000",
        balance: Decimal(string: "2847.20")!,
        currency: "EUR",
        type: "checking",
        lastSyncedAt: Date()
    )

    static let previewList: [Account] = [
        preview,
        Account(
            id: "preview-account-2",
            bankConnectionId: "conn-1",
            name: "Sparkonto",
            iban: "DE89370400440532013001",
            balance: Decimal(string: "8900.50")!,
            currency: "EUR",
            type: "savings",
            lastSyncedAt: Date()
        )
    ]
}

extension Transaction {
    static let preview = Transaction(
        id: "preview-transaction-1",
        accountId: "account-1",
        amount: Decimal(string: "-42.50")!,
        currency: "EUR",
        description: "Café Latte & Croissant",
        merchantName: "Café Milano",
        date: Date(),
        categoryId: "cat-food",
        spaceId: nil,
        isAutoAssigned: false
    )

    static let previewList: [Transaction] = [
        // Today
        Transaction(
            id: "t-1",
            accountId: "a-1",
            amount: Decimal(string: "-42.50")!,
            currency: "EUR",
            description: "Café Latte",
            merchantName: "Café Milano",
            date: Date(),
            categoryId: "cat-food",
            spaceId: nil,
            isAutoAssigned: false
        ),
        Transaction(
            id: "t-2",
            accountId: "a-1",
            amount: Decimal(string: "-125.00")!,
            currency: "EUR",
            description: "Wocheneinkauf",
            merchantName: "REWE",
            date: Date(),
            categoryId: "cat-groceries",
            spaceId: "space-1",
            isAutoAssigned: true
        ),
        // Yesterday
        Transaction(
            id: "t-3",
            accountId: "a-1",
            amount: Decimal(string: "2500.00")!,
            currency: "EUR",
            description: "Gehalt",
            merchantName: "Arbeitgeber GmbH",
            date: Date().addingTimeInterval(-86400),
            categoryId: nil,
            spaceId: nil,
            isAutoAssigned: false
        ),
        Transaction(
            id: "t-4",
            accountId: "a-1",
            amount: Decimal(string: "-35.90")!,
            currency: "EUR",
            description: "Tanken",
            merchantName: "Shell",
            date: Date().addingTimeInterval(-86400),
            categoryId: "cat-transport",
            spaceId: nil,
            isAutoAssigned: true
        ),
        // Earlier
        Transaction(
            id: "t-5",
            accountId: "a-1",
            amount: Decimal(string: "-89.99")!,
            currency: "EUR",
            description: "Monatsabo",
            merchantName: "Netflix & Spotify",
            date: Date().addingTimeInterval(-172800),
            categoryId: "cat-entertainment",
            spaceId: nil,
            isAutoAssigned: false
        ),
    ]
}

extension Space {
    static let preview = Space(
        id: "preview-space-1",
        name: "Hauptkonto",
        budgetAmount: Decimal(string: "2147.20")!,
        budgetPeriod: "monthly",
        color: "#111111",
        icon: "creditcard",
        createdAt: Date()
    )

    static let previewList: [Space] = [
        Space(
            id: "s-1",
            name: "Hauptkonto",
            budgetAmount: Decimal(string: "2147.20")!,
            budgetPeriod: "monthly",
            color: "#111111",
            icon: "creditcard",
            createdAt: Date()
        ),
        Space(
            id: "s-2",
            name: "Urlaub",
            budgetAmount: Decimal(string: "420.00")!,
            budgetPeriod: "monthly",
            color: "#C49332",
            icon: "🏝️",
            createdAt: Date()
        ),
        Space(
            id: "s-3",
            name: "Essen",
            budgetAmount: Decimal(string: "180.00")!,
            budgetPeriod: "monthly",
            color: "#C45A4A",
            icon: "🍽️",
            createdAt: Date()
        ),
    ]

    static let sharedPreviewList: [Space] = [
        Space(
            id: "s-shared-1",
            name: "Auto",
            budgetAmount: Decimal(string: "100.00")!,
            budgetPeriod: "monthly",
            color: "#A0A0A0",
            icon: "🚗",
            createdAt: Date()
        ),
    ]
}

extension BankConnection {
    static let preview = BankConnection(
        id: "conn-1",
        provider: "Deutsche Bank",
        status: "active",
        consentExpiresAt: Date().addingTimeInterval(86400 * 90),
        createdAt: Date()
    )
}

extension Category {
    static let preview = Category(
        id: "cat-1",
        name: "Essen & Trinken",
        icon: "🍽️",
        color: "#C45A4A"
    )
}

extension CategorizationRule {
    static let preview = CategorizationRule(
        id: "rule-1",
        field: "merchantName",
        operator: "contains",
        value: "Café",
        targetSpaceId: "space-1",
        priority: 1,
        isActive: true
    )
}

extension SpaceMember {
    static let preview = SpaceMember(
        id: "member-1",
        spaceId: "space-1",
        userId: "user-1",
        role: "admin",
        joinedAt: Date()
    )
}
#endif
