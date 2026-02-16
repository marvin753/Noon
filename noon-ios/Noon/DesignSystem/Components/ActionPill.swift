// ActionPill.swift
// Noon
// Purpose: White pill button with icon and label for action strip

import SwiftUI

struct ActionPill: View {
    let icon: String  // SF Symbol name
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                Text(label)
                    .bodyMediumStyle()
            }
            .foregroundColor(.text)
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .background(Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: NoonSpacing.radiusButton))
            .overlay(
                RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                    .strokeBorder(Color.black.opacity(0.04), lineWidth: 0.5)
            )
            .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
            .shadow(color: Color.black.opacity(0.02), radius: 12, x: 0, y: 8)
        }
    }
}

#Preview {
    HStack(spacing: NoonSpacing.sm) {
        ActionPill(icon: "plus", label: "Hinzufügen") {}
        ActionPill(icon: "arrow.up.right", label: "Senden") {}
        ActionPill(icon: "ellipsis", label: "Mehr") {}
    }
    .padding()
    .background(Color.bg)
}
