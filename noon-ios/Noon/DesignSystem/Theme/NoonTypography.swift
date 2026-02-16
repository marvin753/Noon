// NoonTypography.swift
// Noon
// Purpose: Typography system with Outfit font family and brand-specific type scale
// Brand Identity: Precise type scale with specific letter-spacing for each level

import SwiftUI

// MARK: - Font Extension

extension Font {
    // MARK: - Brand Type Scale (Outfit + System Fallbacks)

    /// Display style - 50pt light, -2.5 letter-spacing (main balance number)
    static let noonDisplay: Font = .custom("Outfit-Light", size: 50)
    static let noonDisplayFallback: Font = .system(size: 50, weight: .light)

    /// Display cents - 30pt light, -1 letter-spacing (cents portion)
    static let noonDisplayCents: Font = .custom("Outfit-Light", size: 30)
    static let noonDisplayCentsFallback: Font = .system(size: 30, weight: .light)

    /// Heading 1 - 23pt bold, -0.6 letter-spacing (logo, big headings)
    static let noonHeading1: Font = .custom("Outfit-Bold", size: 23)
    static let noonHeading1Fallback: Font = .system(size: 23, weight: .bold)

    /// Heading 2 - 15pt semibold, -0.2 letter-spacing (card names, sub-headings)
    static let noonHeading2: Font = .custom("Outfit-SemiBold", size: 15)
    static let noonHeading2Fallback: Font = .system(size: 15, weight: .semibold)

    /// Body - 15pt bold, -0.5 letter-spacing (amounts with tabular nums)
    static let noonBody: Font = .custom("Outfit-Bold", size: 15)
    static let noonBodyFallback: Font = .system(size: 15, weight: .bold)

    /// Body medium - 13pt medium, -0.1 letter-spacing (action buttons, descriptions)
    static let noonBodyMedium: Font = .custom("Outfit-Medium", size: 13)
    static let noonBodyMediumFallback: Font = .system(size: 13, weight: .medium)

    /// Caption - 12pt regular, 0 letter-spacing (meta info)
    static let noonCaption: Font = .custom("Outfit-Regular", size: 12)
    static let noonCaptionFallback: Font = .system(size: 12, weight: .regular)

    /// Caption strong - 12.5pt semibold, 0.2 letter-spacing (trend badges)
    static let noonCaptionStrong: Font = .custom("Outfit-SemiBold", size: 12.5)
    static let noonCaptionStrongFallback: Font = .system(size: 12.5, weight: .semibold)

    /// Overline - 11pt semibold, 2.2 letter-spacing (section labels UPPERCASE)
    static let noonOverline: Font = .custom("Outfit-SemiBold", size: 11)
    static let noonOverlineFallback: Font = .system(size: 11, weight: .semibold)

    /// Micro - 10pt medium, 0.2 letter-spacing (nav labels)
    static let noonMicro: Font = .custom("Outfit-Medium", size: 10)
    static let noonMicroFallback: Font = .system(size: 10, weight: .medium)

    /// Micro bold - 8pt bold, 0 letter-spacing (avatar initials)
    static let noonMicroBold: Font = .custom("Outfit-Bold", size: 8)
    static let noonMicroBoldFallback: Font = .system(size: 8, weight: .bold)

    // MARK: - Legacy Compatibility (mapped to new scale)

    /// Legacy title (maps to heading1)
    static var noonTitle: Font { noonHeading1 }
    static var noonTitleFallback: Font { noonHeading1Fallback }

    /// Legacy headline (maps to heading2)
    static var noonHeadline: Font { noonHeading2 }
    static var noonHeadlineFallback: Font { noonHeading2Fallback }
}

// MARK: - Text Style Modifiers

extension Text {
    /// Apply display style with proper letter-spacing (-2.5)
    func displayStyle() -> some View {
        self.font(.noonDisplay)
            .tracking(-2.5)
    }

    /// Apply display cents style with proper letter-spacing (-1)
    func displayCentsStyle() -> some View {
        self.font(.noonDisplayCents)
            .tracking(-1)
    }

    /// Apply heading 1 style with proper letter-spacing (-0.6)
    func heading1Style() -> some View {
        self.font(.noonHeading1)
            .tracking(-0.6)
    }

    /// Apply heading 2 style with proper letter-spacing (-0.2)
    func heading2Style() -> some View {
        self.font(.noonHeading2)
            .tracking(-0.2)
    }

    /// Apply body style with proper letter-spacing and tabular nums (-0.5)
    func bodyStyle() -> some View {
        self.font(.noonBody)
            .tracking(-0.5)
            .monospacedDigit() // tabular-nums for amounts
    }

    /// Apply body medium style with proper letter-spacing (-0.1)
    func bodyMediumStyle() -> some View {
        self.font(.noonBodyMedium)
            .tracking(-0.1)
    }

    /// Apply caption style (0 letter-spacing)
    func captionStyle() -> some View {
        self.font(.noonCaption)
    }

    /// Apply caption strong style with proper letter-spacing (0.2)
    func captionStrongStyle() -> some View {
        self.font(.noonCaptionStrong)
            .tracking(0.2)
    }

    /// Apply overline style with proper letter-spacing (2.2) for section labels
    func overlineStyle() -> some View {
        self.font(.noonOverline)
            .tracking(2.2)
            .textCase(.uppercase)
    }

    /// Apply micro style with proper letter-spacing (0.2)
    func microStyle() -> some View {
        self.font(.noonMicro)
            .tracking(0.2)
    }

    /// Apply micro bold style (0 letter-spacing)
    func microBoldStyle() -> some View {
        self.font(.noonMicroBold)
    }
}

// MARK: - View Modifiers for Reusable Styles

struct DisplayStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.noonDisplay)
            .tracking(-2.5)
    }
}

struct OverlineStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.noonOverline)
            .tracking(2.2)
            .textCase(.uppercase)
    }
}

struct BodyAmountStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.noonBody)
            .tracking(-0.5)
            .monospacedDigit()
    }
}

extension View {
    /// Apply display style modifier
    func noonDisplayStyle() -> some View {
        modifier(DisplayStyleModifier())
    }

    /// Apply overline style modifier (section labels)
    func noonOverlineStyle() -> some View {
        modifier(OverlineStyleModifier())
    }

    /// Apply body amount style modifier (with tabular nums)
    func noonBodyAmountStyle() -> some View {
        modifier(BodyAmountStyleModifier())
    }
}
