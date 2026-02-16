// SendView.swift
// Noon
// Purpose: Senden tab - brand-styled money transfer interface

import SwiftUI

struct SendView: View {
    @StateObject private var viewModel = SendViewModel()
    @FocusState private var recipientFieldFocused: Bool

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Text("Senden")
                        .font(.noonHeading1)
                        .tracking(-0.6)
                        .foregroundColor(.text)
                    Spacer()
                }
                .padding(.horizontal, NoonSpacing.topBarPadding)
                .padding(.top, 6)
                .padding(.bottom, NoonSpacing.xxl)

                ScrollView {
                    VStack(spacing: 0) {
                        // Amount input section
                        VStack(spacing: 10) {
                            Text("BETRAG")
                                .font(.noonOverline)
                                .tracking(2.2)
                                .foregroundColor(.textFaint)

                            Text(viewModel.displayAmount)
                                .font(.system(size: 50, weight: .light))
                                .tracking(-2.5)
                                .monospacedDigit()
                                .foregroundColor(viewModel.amount.isEmpty ? .textFaint : .text)
                                .animation(.easeInOut(duration: 0.2), value: viewModel.displayAmount)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 50)

                        // Number pad
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                NumberButton(digit: "1", viewModel: viewModel)
                                NumberButton(digit: "2", viewModel: viewModel)
                                NumberButton(digit: "3", viewModel: viewModel)
                            }
                            HStack(spacing: 16) {
                                NumberButton(digit: "4", viewModel: viewModel)
                                NumberButton(digit: "5", viewModel: viewModel)
                                NumberButton(digit: "6", viewModel: viewModel)
                            }
                            HStack(spacing: 16) {
                                NumberButton(digit: "7", viewModel: viewModel)
                                NumberButton(digit: "8", viewModel: viewModel)
                                NumberButton(digit: "9", viewModel: viewModel)
                            }
                            HStack(spacing: 16) {
                                Button {
                                    viewModel.appendDecimalSeparator()
                                } label: {
                                    Text(",")
                                        .font(.system(size: 28, weight: .light))
                                        .foregroundColor(.text)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(Color.surface)
                                        .cornerRadius(NoonSpacing.radiusButton)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                                                .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                                        )
                                }

                                NumberButton(digit: "0", viewModel: viewModel)

                                Button {
                                    viewModel.deleteLastDigit()
                                } label: {
                                    Image(systemName: "delete.left")
                                        .font(.system(size: 24))
                                        .foregroundColor(.textMid)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(Color.surface)
                                        .cornerRadius(NoonSpacing.radiusButton)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                                                .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, NoonSpacing.lg)
                        .padding(.bottom, NoonSpacing.xxl)

                        // Recipient section
                        VStack(alignment: .leading, spacing: NoonSpacing.md) {
                            SectionLabel(text: "AN")
                                .padding(.horizontal, NoonSpacing.xl)

                            // Recipient input field
                            HStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textFaint)
                                    .font(.system(size: 16))

                                TextField("Name oder IBAN", text: $viewModel.recipient)
                                    .font(.system(size: 15))
                                    .foregroundColor(.text)
                                    .focused($recipientFieldFocused)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()

                                if !viewModel.recipient.isEmpty {
                                    Button {
                                        viewModel.recipient = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.textFaint)
                                            .font(.system(size: 18))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color.surface)
                            .cornerRadius(NoonSpacing.radiusButton)
                            .overlay(
                                RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                                    .stroke(recipientFieldFocused ? Color.text.opacity(0.15) : Color.black.opacity(0.04), lineWidth: 0.5)
                            )
                            .padding(.horizontal, NoonSpacing.lg)

                            // Quick contacts
                            QuickContactsRow()
                                .padding(.horizontal, NoonSpacing.lg)
                                .padding(.top, 8)
                        }
                        .padding(.bottom, 30)
                    }
                }

                Spacer()

                // Send button
                Button {
                    Task {
                        await viewModel.send()
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16))

                        Text("Senden")
                            .font(.noonBodyMedium)
                            .tracking(-0.1)
                    }
                    .foregroundColor(canSend ? .text : .textFaint)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.surface)
                    .cornerRadius(NoonSpacing.radiusPill)
                    .overlay(
                        RoundedRectangle(cornerRadius: NoonSpacing.radiusPill)
                            .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                    )
                    .opacity(canSend ? 1.0 : 0.6)
                }
                .disabled(!canSend || viewModel.isSending)
                .padding(.horizontal, NoonSpacing.lg)
                .padding(.bottom, 100) // Tab bar + safe area
            }
        }
        .alert("Fehler", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }

    private var canSend: Bool {
        !viewModel.amount.isEmpty && !viewModel.recipient.isEmpty
    }
}

// MARK: - Number Button

struct NumberButton: View {
    let digit: String
    @ObservedObject var viewModel: SendViewModel

    var body: some View {
        Button {
            viewModel.appendDigit(digit)
        } label: {
            Text(digit)
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.text)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.surface)
                .cornerRadius(NoonSpacing.radiusButton)
                .overlay(
                    RoundedRectangle(cornerRadius: NoonSpacing.radiusButton)
                        .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                )
        }
    }
}

// MARK: - Quick Contacts Row

struct QuickContactsRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Zuletzt verwendet")
                .font(.noonCaption)
                .foregroundColor(.textLight)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(0..<5, id: \.self) { index in
                        QuickContactButton(
                            initials: ["MK", "JD", "SA", "LM", "TW"][index],
                            name: ["Max", "Julia", "Sarah", "Leon", "Tim"][index]
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Quick Contact Button

struct QuickContactButton: View {
    let initials: String
    let name: String

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.05))
                    .frame(width: 56, height: 56)

                Text(initials)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.text)
            }

            Text(name)
                .font(.noonCaption)
                .foregroundColor(.textMid)
                .lineLimit(1)
        }
        .frame(width: 64)
    }
}

#Preview {
    SendView()
}
