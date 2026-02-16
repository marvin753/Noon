// ProgressBar.swift
// Noon
// Purpose: 3px track progress bar with smooth animation

import SwiftUI

struct ProgressBar: View {
    let progress: Double  // 0.0-1.0
    var fillColor: Color = .text
    var trackColor: Color = .divider

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: NoonSpacing.radiusProgress)
                    .fill(trackColor)
                    .frame(height: 3)

                // Fill
                RoundedRectangle(cornerRadius: NoonSpacing.radiusProgress)
                    .fill(fillColor)
                    .frame(width: max(0, min(geometry.size.width * progress, geometry.size.width)), height: 3)
                    .animation(.timingCurve(0.4, 0.0, 0.2, 1.0, duration: 0.3), value: progress)
            }
        }
        .frame(height: 3)
    }
}

#Preview {
    VStack(spacing: NoonSpacing.lg) {
        ProgressBar(progress: 0.3)
            .frame(width: 200)

        ProgressBar(progress: 0.65, fillColor: .green)
            .frame(width: 200)

        ProgressBar(progress: 0.85, fillColor: .warm)
            .frame(width: 200)
    }
    .padding()
    .background(Color.bg)
}
