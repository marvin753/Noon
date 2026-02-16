// LoadingView.swift
// Noon
// Purpose: Reusable loading indicator component

import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."

    var body: some View {
        VStack(spacing: NoonSpacing.md) {
            ProgressView()
                .tint(.textLight)
            Text(message)
                .font(.noonBodyMedium)
                .foregroundColor(.textMid)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
    }
}

#Preview {
    LoadingView()
}
