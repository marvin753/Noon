// DateFormatting.swift
// Noon
// Purpose: Centralized date formatting utilities for German locale

import Foundation

struct NoonDateFormatter {
    /// Returns relative German date: "Heute", "Gestern", or formatted date
    static func relativeDate(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) { return "Heute" }
        if calendar.isDateInYesterday(date) { return "Gestern" }

        // Check if this week
        if let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date()),
           date > weekAgo {
            return "Diese Woche"
        }

        // Otherwise format as "15. Feb 2026"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d. MMM yyyy"
        return formatter.string(from: date)
    }

    /// Section group key for transaction list
    static func sectionKey(_ date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) { return "HEUTE" }
        if calendar.isDateInYesterday(date) { return "GESTERN" }
        if let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date()),
           date > weekAgo { return "DIESE WOCHE" }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date).uppercased()
    }

    /// Short time: "14:30"
    static func shortTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - Date Extension

extension Date {
    /// Returns relative German date string
    var relativeGermanDate: String {
        NoonDateFormatter.relativeDate(self)
    }

    /// Returns section key for grouping transactions
    var sectionKey: String {
        NoonDateFormatter.sectionKey(self)
    }

    /// Returns short time format
    var shortTime: String {
        NoonDateFormatter.shortTime(self)
    }
}
