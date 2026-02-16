// NoonLogo.swift
// Noon
// Purpose: Brand logo with warm dot

import SwiftUI

struct NoonLogo: View {
    var height: CGFloat = 28

    var body: some View {
        Image("NoonLogo")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
    }
}

#Preview {
    NoonLogo()
        .padding()
        .background(Color.bg)
}
