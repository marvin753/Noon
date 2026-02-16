// Logger.swift
// Noon
// Purpose: Centralized logging for debugging and error tracking

import Foundation
import OSLog

struct Logger {
    static let app = os.Logger(subsystem: "com.noon.app", category: "app")
    static let network = os.Logger(subsystem: "com.noon.app", category: "network")
    static let database = os.Logger(subsystem: "com.noon.app", category: "database")

    // TODO: Add convenience logging methods
    // TODO: Implement log levels (debug, info, error)
    // TODO: Add structured logging support
}
