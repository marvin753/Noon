// NoonSpacing.swift
// Noon
// Purpose: Consistent spacing and layout constants from brand identity
// Brand Identity: Precise spacing tokens for the minimalist aesthetic

import SwiftUI

enum NoonSpacing {
    // MARK: - Core Spacing Tokens

    /// Extra small - 4pt (micro gaps, tight spacing)
    static let xs: CGFloat = 4

    /// Small - 8pt (action pill gaps, compact spacing)
    static let sm: CGFloat = 8

    /// Card gap - 10pt (spacing between space cards in stack)
    static let cardGap: CGFloat = 10

    /// Medium - 14pt (section label to content)
    static let md: CGFloat = 14

    /// Base - 16pt (standard spacing unit, backward compatibility)
    static let base: CGFloat = 16

    /// Large - 22pt (horizontal padding for cards/action strip)
    static let lg: CGFloat = 22

    /// Top bar padding - 26pt
    static let topBarPadding: CGFloat = 26

    /// Extra large - 28pt (horizontal padding for balance/section labels)
    static let xl: CGFloat = 28

    /// Section spacing - 30pt (vertical spacing after space stacks)
    static let sectionSpacing: CGFloat = 30

    /// Balance to actions - 32pt (spacing from balance to action strip)
    static let balanceToActions: CGFloat = 32

    /// Extra extra large - 36pt (top bar to balance, action strip to spaces)
    static let xxl: CGFloat = 36

    // MARK: - Border Radius Tokens

    /// Card radius - 18pt (main card containers)
    static let radiusCard: CGFloat = 18

    /// Button radius - 14pt (action pills, buttons)
    static let radiusButton: CGFloat = 14

    /// Icon radius - 13pt (space icons, small containers)
    static let radiusIcon: CGFloat = 13

    /// Pill radius - 100pt (trend badges, full pill shapes)
    static let radiusPill: CGFloat = 100

    /// Progress radius - 3pt (progress bars)
    static let radiusProgress: CGFloat = 3

    // MARK: - Legacy Compatibility

    /// Legacy small radius (backward compatibility)
    static let radiusSmall: CGFloat = 8

    /// Legacy medium radius (backward compatibility)
    static let radiusMedium: CGFloat = 12

    /// Legacy large radius (backward compatibility)
    static let radiusLarge: CGFloat = 16
}

// MARK: - Shadow Styles

extension View {
    /// Apply subtle 3-layer card shadow from brand identity
    func noonCardShadow() -> some View {
        self
            .shadow(color: Color.black.opacity(0.02), radius: 0.5, x: 0, y: 0.5)
            .shadow(color: Color.black.opacity(0.02), radius: 1.5, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 2)
    }

    /// Apply card border from brand identity (0.5px solid with very subtle color)
    func noonCardBorder() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: NoonSpacing.radiusCard)
                .strokeBorder(Color.black.opacity(0.04), lineWidth: 0.5)
        )
    }

    /// Apply complete card styling (shadow + border)
    func noonCardStyle() -> some View {
        self
            .noonCardShadow()
            .noonCardBorder()
    }
}

// MARK: - Spacing Helpers

extension EdgeInsets {
    /// Standard card padding (horizontal: lg, vertical: lg)
    static var noonCard: EdgeInsets {
        EdgeInsets(top: NoonSpacing.lg, leading: NoonSpacing.lg, bottom: NoonSpacing.lg, trailing: NoonSpacing.lg)
    }

    /// Screen edge padding (horizontal: xl)
    static var noonScreen: EdgeInsets {
        EdgeInsets(top: 0, leading: NoonSpacing.xl, bottom: 0, trailing: NoonSpacing.xl)
    }

    /// Action strip padding (horizontal: lg, vertical: md)
    static var noonActionStrip: EdgeInsets {
        EdgeInsets(top: NoonSpacing.md, leading: NoonSpacing.lg, bottom: NoonSpacing.md, trailing: NoonSpacing.lg)
    }
}
