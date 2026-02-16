// NoonTextField.swift
// Noon
// Purpose: Styled text field component with validation states

import SwiftUI

struct NoonTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            // TODO: Implement text field styling
            // TODO: Add error state styling
            // TODO: Add focus state
        }
    }
}

#Preview {
    NoonTextField(placeholder: "Email", text: .constant(""))
}
