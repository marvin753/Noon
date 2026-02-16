// NoonCard.swift
// Noon
// Purpose: Reusable card container component

import SwiftUI

struct NoonCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(.top, 18)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .background(Color.surface)
            .cornerRadius(NoonSpacing.radiusCard)
            .overlay(
                RoundedRectangle(cornerRadius: NoonSpacing.radiusCard)
                    .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
            )
            .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
            .shadow(color: Color.black.opacity(0.02), radius: 12, x: 0, y: 8)
    }
}

#Preview {
    VStack {
        NoonCard {
            VStack(alignment: .leading, spacing: NoonSpacing.sm) {
                Text("Card Title")
                    .font(.noonHeadlineFallback)
                    .foregroundColor(.text)
                Text("Card content goes here")
                    .font(.noonBodyFallback)
                    .foregroundColor(.textSecondary)
            }
        }
    }
    .padding()
    .background(Color.bg)
}
