// CardModifier.swift
// Noon
// Purpose: View modifier for applying card styling to any view

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        // TODO: Implement card styling
        // TODO: Add background
        // TODO: Add corner radius
        // TODO: Add shadow
        // TODO: Add padding
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}
