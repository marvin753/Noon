// InviteMemberView.swift
// Noon
// Purpose: Form for inviting members to a shared space

import SwiftUI

struct InviteMemberView: View {
    @Environment(\.dismiss) private var dismiss
    let space: Space

    var body: some View {
        Text("InviteMemberView")
        // TODO: Implement member invitation form
        // TODO: Add email input
        // TODO: Add role selection
        // TODO: Add send invitation button
    }
}

#Preview {
    InviteMemberView(space: .preview)
}
