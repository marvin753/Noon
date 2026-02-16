// TrendBadge.swift
// Noon
// Purpose: Small pill badge showing percentage trend with color coding

import SwiftUI

enum TrendType {
    case positive
    case negative
    case neutral

    var color: Color {
        switch self {
        case .positive: return .green
        case .negative: return .red
        case .neutral: return .textMid
        }
    }

    var backgroundColor: Color {
        switch self {
        case .positive: return .greenBg
        case .negative: return .redBg
        case .neutral: return Color.textMid.opacity(0.06)
        }
    }
}

struct TrendBadge: View {
    let text: String
    let type: TrendType

    var body: some View {
        Text(text)
            .captionStrongStyle()
            .foregroundColor(type.color)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: NoonSpacing.radiusPill))
    }
}

#Preview {
    VStack(spacing: NoonSpacing.md) {
        TrendBadge(text: "+4,2 %", type: .positive)
        TrendBadge(text: "-2,1 %", type: .negative)
        TrendBadge(text: "0,0 %", type: .neutral)
    }
    .padding()
    .background(Color.bg)
}
