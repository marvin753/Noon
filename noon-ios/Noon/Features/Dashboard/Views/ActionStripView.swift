// ActionStripView.swift
// Noon
// Purpose: Three-button action strip for main dashboard actions

import SwiftUI

struct ActionStripView: View {
    var body: some View {
        HStack(spacing: NoonSpacing.sm) {
            ActionPill(icon: "plus", label: "Hinzufügen") {
                // TODO: Add funds action
            }

            ActionPill(icon: "arrow.up.right", label: "Senden") {
                // TODO: Send money action
            }

            ActionPill(icon: "ellipsis", label: "Mehr") {
                // TODO: More actions
            }
        }
    }
}

#Preview {
    ActionStripView()
        .padding()
        .background(Color.bg)
}
