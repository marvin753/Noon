// AvatarStack.swift
// Noon
// Purpose: Overlapping circular avatars showing member initials

import SwiftUI

struct AvatarStack: View {
    let initials: [String]  // e.g., ["M", "T"]
    var size: CGFloat = 18
    var overlapOffset: CGFloat = -6

    var body: some View {
        HStack(spacing: overlapOffset) {
            ForEach(Array(initials.enumerated()), id: \.offset) { index, initial in
                Circle()
                    .fill(Color.surface)
                    .overlay(
                        Circle()
                            .strokeBorder(Color.divider, lineWidth: 1)
                    )
                    .overlay(
                        Text(initial)
                            .microBoldStyle()
                            .foregroundColor(.textMid)
                    )
                    .frame(width: size, height: size)
                    .zIndex(Double(initials.count - index))
            }
        }
    }
}

#Preview {
    VStack(spacing: NoonSpacing.lg) {
        AvatarStack(initials: ["M", "T"])
        AvatarStack(initials: ["A", "B", "C"], size: 24, overlapOffset: -8)
    }
    .padding()
    .background(Color.bg)
}
