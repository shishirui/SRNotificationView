//
//  ContentView.swift
//  SRNotificationView
//
//  Created by rexshi on 2025/11/1.
//

import SwiftUI

struct ContentView: View {
    @State private var showBanner: Bool = true
    @State private var showSkipAd: Bool = true
    @State private var useLegacyEffect: Bool = false
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // Original page content
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(0..<12, id: \.self) { _ in
                            Text(" Hello, world! Hello, world! Hello, world!")
                                .font(.title3)
                                .bold()
                        }
                    }
                    .padding()
                }

                // Bottom control buttons
                VStack(spacing: 8) {
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            showBanner.toggle()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: showBanner ? "bell.slash" : "bell")
                            Text(showBanner ? "Hide Banner" : "Show Banner")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.gradient)
                        )
                        .foregroundStyle(.white)
                        .font(.callout)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            showSkipAd.toggle()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: showSkipAd ? "eye.slash" : "eye")
                            Text(showSkipAd ? "Hide Ad Banner" : "Show Ad Banner")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.orange.gradient)
                        )
                        .foregroundStyle(.white)
                        .font(.callout)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            useLegacyEffect.toggle()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: useLegacyEffect ? "checkmark.circle.fill" : "circle")
                            Text(useLegacyEffect ? "Use iOS 26+ Effect" : "Use iOS 25- Effect")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.purple.gradient)
                        )
                        .foregroundStyle(.white)
                        .font(.callout)
                    }
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            isDarkMode.toggle()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            Text(isDarkMode ? "Light Mode" : "Dark Mode")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.yellow.gradient)
                        )
                        .foregroundStyle(.white)
                        .font(.callout)
                    }
                }
                .padding()
            }

            // Top Notification Banners
            VStack(spacing: 8) {
                if showBanner {
                    SRNotificationView.notification(
                        icon: "bell.badge.fill",
                        iconColor: .blue,
                        title: "Saved",
                        subtitle: "Your changes have been synced,",
                        useLegacyEffect: useLegacyEffect
                    ) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            showBanner = false
                        }
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }

                if showSkipAd {
                    SRNotificationView.action(
                        icon: "play.circle.fill",
                        iconColor: .orange,
                        title: "Skip ads?",
                        subtitle: "Don't wasting your time.",
                        actionButtonText: "Skip",
                        actionButtonStyle: .primary(backgroundColor: .black, textColor: .white),
                        useLegacyEffect: useLegacyEffect
                    ) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                            showSkipAd = false
                        }
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .zIndex(1)
        }
        .animation(.easeInOut, value: showBanner)
        .animation(.easeInOut, value: showSkipAd)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
