// NoonButton.swift
// Noon
// Purpose: Reusable button component with Noon design system styles

import SwiftUI

enum NoonButtonStyle {
    case primary
    case secondary
    case ghost
}

struct NoonButton: View {
    let title: String
    let icon: String?
    let style: NoonButtonStyle
    let action: () -> Void

    init(title: String, icon: String? = nil, style: NoonButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                }
                Text(title)
                    .font(.noonBodyMedium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .textMid
        case .secondary:
            return .accent
        case .ghost:
            return .textMid
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .surface
        case .secondary, .ghost:
            return .clear
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary:
            return Color.black.opacity(0.04)
        case .secondary:
            return .accent
        case .ghost:
            return .clear
        }
    }

    private var borderWidth: CGFloat {
        switch style {
        case .primary:
            return 0.5
        case .secondary:
            return 1
        case .ghost:
            return 0
        }
    }

    private var cornerRadius: CGFloat {
        switch style {
        case .primary:
            return NoonSpacing.radiusButton
        case .secondary:
            return NoonSpacing.radiusButton
        case .ghost:
            return NoonSpacing.radiusButton
        }
    }

    private var shadowColor: Color {
        switch style {
        case .primary:
            return Color.black.opacity(0.03)
        case .secondary, .ghost:
            return .clear
        }
    }

    private var shadowRadius: CGFloat {
        style == .primary ? 3 : 0
    }

    private var shadowY: CGFloat {
        style == .primary ? 1 : 0
    }
}

#Preview {
    VStack(spacing: NoonSpacing.base) {
        NoonButton(title: "Primary Button", style: .primary, action: {})
        NoonButton(title: "Secondary Button", style: .secondary, action: {})
        NoonButton(title: "Ghost Button", style: .ghost, action: {})
    }
    .padding()
    .background(Color.bg)
}
