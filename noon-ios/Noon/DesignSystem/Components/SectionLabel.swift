// SectionLabel.swift
// Noon
// Purpose: UPPERCASE section label with proper letter-spacing

import SwiftUI

struct SectionLabel: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .overlineStyle()
                .foregroundColor(.textFaint)
            Spacer()
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: NoonSpacing.lg) {
        SectionLabel(text: "Spaces")
        SectionLabel(text: "Geteilt")
        SectionLabel(text: "Transaktionen")
    }
    .padding()
    .background(Color.bg)
}
