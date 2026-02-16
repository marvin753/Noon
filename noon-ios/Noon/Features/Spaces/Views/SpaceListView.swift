// SpaceListView.swift
// Noon
// Purpose: List view displaying all shared financial spaces

import SwiftUI

struct SpaceListView: View {
    @StateObject private var viewModel = SpacesViewModel()
    @State private var showingCreateSpace = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: NoonSpacing.base) {
                    ForEach(viewModel.spaces) { space in
                        NavigationLink {
                            SpaceDetailView(space: space)
                        } label: {
                            SpaceGridItem(space: space)
                        }
                    }
                }
                .padding(NoonSpacing.base)
            }
            .background(Color.bg)
            .navigationTitle("Spaces")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingCreateSpace = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accent)
                    }
                }
            }
            .sheet(isPresented: $showingCreateSpace) {
                CreateSpaceView()
            }
            .task {
                await viewModel.loadSpaces()
            }
        }
    }
}

struct SpaceGridItem: View {
    let space: Space

    var body: some View {
        VStack(alignment: .leading, spacing: NoonSpacing.sm) {
            HStack {
                Text(space.icon)
                    .font(.system(size: 32))
                Spacer()
                Circle()
                    .fill(Color(hex: space.color))
                    .frame(width: 12, height: 12)
            }

            Text(space.name)
                .font(.noonHeadlineFallback)
                .foregroundColor(.text)

            VStack(alignment: .leading, spacing: 4) {
                Text("Budget")
                    .font(.noonCaptionFallback)
                    .foregroundColor(.textSecondary)

                Text(space.budgetAmount.currencyFormatted())
                    .font(.noonBodyFallback)
                    .fontWeight(.semibold)
                    .foregroundColor(.text)

                Text(space.budgetPeriod)
                    .font(.noonCaptionFallback)
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(NoonSpacing.base)
        .background(Color.surface)
        .cornerRadius(NoonSpacing.radiusMedium)
    }
}

#Preview {
    SpaceListView()
}
