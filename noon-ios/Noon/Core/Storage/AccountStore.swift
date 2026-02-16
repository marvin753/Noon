// AccountStore.swift
// Noon
// Purpose: Local persistence and caching for account data using GRDB

import Foundation
import GRDB

actor AccountStore {
    private let dbManager: DatabaseManager

    init(dbManager: DatabaseManager) {
        self.dbManager = dbManager
    }

    // TODO: Implement CRUD operations for accounts
    // TODO: Add save, fetch, update, delete methods
    // TODO: Add batch sync from API
}
