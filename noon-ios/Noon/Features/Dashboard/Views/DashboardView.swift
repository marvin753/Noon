// DashboardView.swift
// Noon
// Purpose: Main dashboard view matching brand reference design

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var showBalanceDetails = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 1. Top Bar
                topBar
                    .padding(.top, 6)
                    .padding(.horizontal, NoonSpacing.topBarPadding)
                    .padding(.bottom, NoonSpacing.xxl)

                // 2. Balance Area
                BalanceAreaView(
                    balance: viewModel.totalBalance,
                    trendText: viewModel.trendPercentage,
                    trendType: viewModel.trendType
                )
                .padding(.bottom, NoonSpacing.balanceToActions)

                // 3. Action Strip
                ActionStripView()
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.xxl)

                // 4. Spaces Section
                if !viewModel.spaces.isEmpty {
                    SectionLabel(text: "Spaces")
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    VStack(spacing: NoonSpacing.cardGap) {
                        ForEach(viewModel.spaces) { space in
                            SpaceRowCard(space: space)
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)
                }

                // 5. Shared Section
                if !viewModel.sharedSpaces.isEmpty {
                    SectionLabel(text: "Geteilt")
                        .padding(.horizontal, NoonSpacing.xl)
                        .padding(.bottom, NoonSpacing.md)

                    VStack(spacing: NoonSpacing.cardGap) {
                        ForEach(viewModel.sharedSpaces) { space in
                            SharedSpaceCard(space: space)
                        }
                    }
                    .padding(.horizontal, NoonSpacing.lg)
                    .padding(.bottom, NoonSpacing.sectionSpacing)
                }
            }
        }
        .background(Color.bg)
        .task {
            await viewModel.loadData()
        }
    }

    private var topBar: some View {
        HStack {
            // Logo on left
            NoonLogo()

            Spacer()

            // Action buttons on right
            HStack(spacing: 12) {
                Button(action: {
                    showBalanceDetails.toggle()
                }) {
                    Circle()
                        .fill(Color.surface)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: showBalanceDetails ? "eye.slash" : "eye")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.text)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
                }

                Button(action: {
                    // TODO: Show notifications
                }) {
                    Circle()
                        .fill(Color.surface)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: "bell")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.text)
                        )
                        .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 4)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
