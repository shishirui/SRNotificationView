//
//  SRNotificationView.swift
//  test-liquid
//
//  Created by rexshi on 2025/11/1.
//

import SwiftUI

// MARK: - Universal Banner Component
struct SRNotificationView: View {
    let icon: String?
    let iconColor: Color
    let title: String
    let subtitle: String?
    let actionButtonText: String?
    let actionButtonStyle: ActionButtonStyle
    let useLegacyEffect: Bool
    let onAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(iconColor)
                    .frame(width: 32, height: 32)
            }

            // Title and Description
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                if let subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Action Button
            if let actionButtonText {
                Button(action: onAction) {
                    Text(actionButtonText)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(actionButtonStyle.textColor)
                        .frame(height: 32)
                        .frame(minWidth: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(actionButtonStyle.backgroundColor)
                        )
                }
                .buttonStyle(.plain)
            } else {
                // Close Button
                Button(action: onAction) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .padding(8)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .compatibleGlassEffect(in: .rect(cornerRadius: 16.0), useLegacy: useLegacyEffect)
        .shadow(color: .black.opacity(0.1), radius: 10, y: 4)
    }
}

// MARK: - Action Button Style
enum ActionButtonStyle {
    case close
    case primary(backgroundColor: Color = .black, textColor: Color = .white)
    case secondary(backgroundColor: Color = .blue, textColor: Color = .white)
    case custom(backgroundColor: Color, textColor: Color)
    
    var backgroundColor: Color {
        switch self {
        case .close:
            return .clear
        case .primary(let bgColor, _):
            return bgColor
        case .secondary(let bgColor, _):
            return bgColor
        case .custom(let bgColor, _):
            return bgColor
        }
    }
    
    var textColor: Color {
        switch self {
        case .close:
            return .clear
        case .primary(_, let textCol):
            return textCol
        case .secondary(_, let textCol):
            return textCol
        case .custom(_, let textCol):
            return textCol
        }
    }
}

// MARK: - Convenience Initializers
extension SRNotificationView {
    /// Create notification banner with close button
    static func notification(
        icon: String,
        iconColor: Color = .blue,
        title: String,
        subtitle: String? = nil,
        useLegacyEffect: Bool = false,
        onClose: @escaping () -> Void
    ) -> SRNotificationView {
        SRNotificationView(
            icon: icon,
            iconColor: iconColor,
            title: title,
            subtitle: subtitle,
            actionButtonText: nil,
            actionButtonStyle: .close,
            useLegacyEffect: useLegacyEffect,
            onAction: onClose
        )
    }
    
    /// Create action banner with action button
    static func action(
        icon: String,
        iconColor: Color = .orange,
        title: String,
        subtitle: String? = nil,
        actionButtonText: String = "Action",
        actionButtonStyle: ActionButtonStyle = .primary(),
        useLegacyEffect: Bool = false,
        onAction: @escaping () -> Void
    ) -> SRNotificationView {
        SRNotificationView(
            icon: icon,
            iconColor: iconColor,
            title: title,
            subtitle: subtitle,
            actionButtonText: actionButtonText,
            actionButtonStyle: actionButtonStyle,
            useLegacyEffect: useLegacyEffect,
            onAction: onAction
        )
    }
}

// MARK: - Compatibility Extension
extension View {
    @ViewBuilder
    func compatibleGlassEffect(in shape: any Shape, useLegacy: Bool = false) -> some View {
        if useLegacy {
            // Force use legacy effect (iOS 25-)
            self
                .background(.ultraThickMaterial)
                .cornerRadius(16.0)
        } else if #available(iOS 26, *) {
            // iOS 26+ use new effect
            self.glassEffect(in: shape)
        } else {
            // iOS 25- fallback to legacy effect
            self
                .background(.ultraThickMaterial)
                .cornerRadius(16.0)
        }
    }
}
