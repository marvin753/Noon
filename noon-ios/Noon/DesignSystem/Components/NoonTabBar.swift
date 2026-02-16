// NoonTabBar.swift
// Noon
// Purpose: Custom bottom navigation bar matching the Noon brand identity
// Design: Frosted glass background with 4 tab items, warm dot indicator for active state

import SwiftUI

// MARK: - Tab Bar Container
struct NoonTabBar: View {
    @Binding var selectedTab: NoonTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(NoonTab.allCases, id: \.self) { tab in
                Spacer()
                NoonTabItem(
                    tab: tab,
                    isActive: selectedTab == tab
                ) {
                    selectedTab = tab
                }
                Spacer()
            }
        }
        .padding(.top, 12)
        .frame(height: 86)
        .background(
            // Frosted glass effect with warm tint
            ZStack {
                // Base blur layer
                Rectangle()
                    .fill(.ultraThinMaterial)

                // Warm background tint overlay (matches brand background)
                Color.bg.opacity(0.85)
            }
        )
        .overlay(alignment: .top) {
            // Subtle top border line
            Rectangle()
                .fill(Color.black.opacity(0.06))
                .frame(height: 0.5)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Individual Tab Item
struct NoonTabItem: View {
    let tab: NoonTab
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                // Icon
                Image(systemName: tab.iconName)
                    .font(.system(size: 22, weight: isActive ? .medium : .light))
                    .foregroundColor(isActive ? .text : .textFaint)
                    .frame(width: 24, height: 24)

                // Label
                Text(tab.label)
                    .font(.system(size: 10, weight: isActive ? .semibold : .medium))
                    .tracking(0.2)
                    .foregroundColor(isActive ? .text : .textFaint)

                // Active state indicator - warm dot (4x4px)
                if isActive {
                    Circle()
                        .fill(Color.warm)
                        .frame(width: 4, height: 4)
                        .padding(.top, 1)
                } else {
                    // Maintain consistent spacing when inactive
                    Color.clear
                        .frame(width: 4, height: 4)
                        .padding(.top, 1)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 2)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview("Tab Bar - Home Selected") {
    VStack {
        Spacer()
        NoonTabBar(selectedTab: .constant(.home))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
}

#Preview("Tab Bar - Activity Selected") {
    VStack {
        Spacer()
        NoonTabBar(selectedTab: .constant(.activity))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
}

#Preview("Tab Bar - Send Selected") {
    VStack {
        Spacer()
        NoonTabBar(selectedTab: .constant(.send))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
}

#Preview("Tab Bar - Profile Selected") {
    VStack {
        Spacer()
        NoonTabBar(selectedTab: .constant(.profile))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.bg)
}
