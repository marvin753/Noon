// NoonColors.swift
// Noon
// Purpose: Centralized color palette for the Noon design system
// Brand Identity: Light warm minimalist aesthetic with dark mode support

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

extension Color {
    // MARK: - Brand Core Colors

    /// Warm accent color from brand identity (used sparingly: logo, active dots, special highlights)
    static let warm = Color(hex: "#C8966D")

    // MARK: - Semantic Colors (Light/Dark Adaptive)

    /// Main background - warm off-white in light mode, pure black in dark mode
    static let bg = Color(light: "#F7F6F3", dark: "#0A0A0A")

    /// Card and surface backgrounds - pure white in light mode, dark gray in dark mode
    static let surface = Color(light: "#FFFFFF", dark: "#1A1A1A")

    /// Primary text color
    static let text = Color(light: "#111111", dark: "#F5F5F3")

    /// Mid-level text (descriptions, secondary info)
    static let textMid = Color(light: "#555555", dark: "#999999")

    /// Light text (muted info)
    static let textLight = Color(light: "#A0A0A0", dark: "#666666")

    /// Faint text (section labels, subtle info)
    static let textFaint = Color(light: "#C8C8C4", dark: "#444444")

    /// Dividers and subtle borders
    static let divider = Color(light: "#EEEEE9", dark: "#222222")

    /// Accent color (follows primary text)
    static let accent = Color(light: "#111111", dark: "#F5F5F3")

    // MARK: - Status Colors

    /// Success/positive indicator
    static let green = Color(hex: "#2D8653")

    /// Success background (subtle wash) - rgba(45,134,83,0.07)
    static let greenBg = Color(.sRGB, red: 45.0/255.0, green: 134.0/255.0, blue: 83.0/255.0, opacity: 0.07)

    /// Warning/neutral indicator
    static let amber = Color(hex: "#C49332")

    /// Warning background (subtle wash) - rgba(196,147,50,0.06)
    static let amberBg = Color(.sRGB, red: 196.0/255.0, green: 147.0/255.0, blue: 50.0/255.0, opacity: 0.06)

    /// Error/negative indicator
    static let red = Color(hex: "#C45A4A")

    /// Error background (subtle wash) - rgba(196,90,74,0.06)
    static let redBg = Color(.sRGB, red: 196.0/255.0, green: 90.0/255.0, blue: 74.0/255.0, opacity: 0.06)

    // MARK: - Backward Compatibility Aliases

    /// Legacy name for textMid
    static let textSecondary = textMid

    /// Legacy name for green
    static let success = green

    /// Legacy name for red
    static let error = red

    /// Legacy warm dot color (now redirects to warm)
    static let warmDot = warm

    /// Legacy alias for bg (note: don't use "background" as it conflicts with SwiftUI's ShapeStyle.background)
    static let noonBackground = bg
}

// MARK: - Color Initializers

extension Color {
    /// Initialize Color from hex string (supports #RGB, #RRGGBB, #RRGGBBAA)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b, a: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // ARGB (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// Initialize adaptive Color with separate light and dark mode hex values
    init(light lightHex: String, dark darkHex: String) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(Color(hex: darkHex))
            default:
                return UIColor(Color(hex: lightHex))
            }
        })
        #else
        self.init(hex: lightHex)
        #endif
    }
}
