// SpaceIcon.swift
// Noon
// Purpose: Space icon container with emoji or SF Symbol

import SwiftUI

enum SpaceIconVariant {
    case emoji(String, backgroundColor: Color)
    case symbol(String, backgroundColor: Color)

    var backgroundColor: Color {
        switch self {
        case .emoji(_, let bg), .symbol(_, let bg):
            return bg
        }
    }

    var content: String {
        switch self {
        case .emoji(let value, _), .symbol(let value, _):
            return value
        }
    }

    var isEmoji: Bool {
        switch self {
        case .emoji:
            return true
        case .symbol:
            return false
        }
    }
}

struct SpaceIcon: View {
    let variant: SpaceIconVariant
    var size: CGFloat = 44

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: NoonSpacing.radiusIcon)
                .fill(variant.backgroundColor)

            if variant.isEmoji {
                Text(variant.content)
                    .font(.system(size: size * 0.5))
            } else {
                Image(systemName: variant.content)
                    .font(.system(size: size * 0.45, weight: .medium))
                    .foregroundColor(.text)
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: NoonSpacing.lg) {
        SpaceIcon(variant: .symbol("creditcard", backgroundColor: Color.text.opacity(0.08)))
        SpaceIcon(variant: .emoji("🏝️", backgroundColor: .amberBg))
        SpaceIcon(variant: .emoji("🍽️", backgroundColor: .redBg))
        SpaceIcon(variant: .emoji("🚗", backgroundColor: Color.textLight.opacity(0.08)))
    }
    .padding()
    .background(Color.bg)
}
