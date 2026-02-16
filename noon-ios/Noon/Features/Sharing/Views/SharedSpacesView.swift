// SharedSpacesView.swift
// Noon
// Purpose: View showing spaces shared with current user

import SwiftUI

struct SharedSpacesView: View {
    @StateObject private var viewModel = SharingViewModel()

    var body: some View {
        Text("SharedSpacesView")
        // TODO: Implement shared spaces list
        // TODO: Distinguish owned vs member spaces
        // TODO: Show pending invitations
        // TODO: Add accept/decline invitation actions
    }
}

#Preview {
    SharedSpacesView()
}
