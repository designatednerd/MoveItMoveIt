//
//  Buttons.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

public enum ButtonStyle {
    case standard
    case warning
    case destructive
    
    var primaryColor: Color {
        switch self {
        case .standard:
            return .purple500
        case .warning:
            return .yellow600
        case .destructive:
            return .red500
        }
    }
}

// MARK: - Reusable Button Styles

/// The `Primary` button style from the Figma file.
///
/// Note: To get this to fill its parent view, you must pass in `fillWidth` here rather than trying to apply a frame.
///
/// This is because order of modifier application matters to SwiftUI, and applying the frame after applying either the background, the border, or both would mean the button's view would resize, but the background and/or border would not resize with it.
public struct PrimaryButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let action: () -> Void
    let title: any StringProtocol
    let style: ButtonStyle
    let fullWidth: Bool
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - title: The content to display as the button title.
    ///   - style: The ``ButtonStyle`` to apply to this button. Defaults to ``ButtonStyle.standard``.
    ///   - fullWidth: Whether to have the button fill the width of its container. Defaults to `false`.
    ///   - action: The action to perform when the button is tapped.
    public init(title: any StringProtocol,
                style: ButtonStyle = .standard,
                fullWidth: Bool = false,
                action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.style = style
        self.fullWidth = fullWidth
    }
    
    public var body: some View {
        Button {
            self.action()
        } label: {
            Title3Text(title)
                .foregroundColor(.gray50)
                .padding([.top, .bottom], 12)
                .padding([.leading, .trailing], 16)
                .if(self.fullWidth) { view in
                    view.frame(maxWidth: .infinity)
                }
                .roundedCornerBackground(self.backgroundColor, radius: 10)
        }
    }
    
    private var backgroundColor: Color {
        if self.isEnabled {
            return self.style.primaryColor
        } else {
            return .gray400
        }
    }
}

/// The `Secondary` button style from the Figma file.
///
/// Note: To get this to fill its parent view, you must pass in `fillWidth` here rather than trying to apply a frame.
///
/// This is because order of modifier application matters to SwiftUI, and applying the frame after applying either the background, the border, or both would mean the button's view would resize, but the background and/or border would not resize with it.
public struct SecondaryButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let action: () -> Void
    let title: any StringProtocol
    let style: ButtonStyle
    let fullWidth: Bool
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - title: The content to display as the button title.
    ///   - style: The ``ButtonStyle`` to apply to this button. Defaults to ``ButtonStyle.standard``.
    ///   - fullWidth: Whether to have the button fill the width of its container. Defaults to `false`.
    ///   - action: The action to perform when the button is tapped.
    public init(title: any StringProtocol,
                style: ButtonStyle = .standard,
                fullWidth: Bool = false,
                action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.style = style
        self.fullWidth = fullWidth
    }
    
    public var body: some View {
        Button {
            self.action()
        } label: {
            Title3Text(title)
                .foregroundColor(self.primaryColor)
                .padding([.top, .bottom], 12)
                .padding([.leading, .trailing], 16)
                .if(self.fullWidth) { view in
                    view.frame(maxWidth: .infinity)
                }
                .roundedCornerBackground(.clear,
                                         radius: 10,
                                         borderInfo: self.borderInfo)
        }
    }
    
    private var borderInfo: BorderInfo {
        BorderInfo(color: self.primaryColor, width: 1)
    }
    
    private var primaryColor: Color {
        if self.isEnabled {
            return self.style.primaryColor
        } else {
            return .gray400
        }
    }
}

/// The `Tertiary` button style from the Figma file.
///
/// Note: This button does not have the option to fill its parent's width since it is not applying any styles that would need to be redrawn if the button's frame changes.
public struct TertiaryButton: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let action: () -> Void
    let title: any StringProtocol
    let style: ButtonStyle
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - title: The content to display as the button title.
    ///   - style: The ``ButtonStyle`` to apply to this button. Defaults to ``ButtonStyle.standard``.
    ///   - action: The action to perform when the button is tapped.
    public init(title: any StringProtocol,
                style: ButtonStyle = .standard,
                action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.style = style
    }
    
    public var body: some View {
        Button {
            self.action()
        } label: {
            Title3Text(title)
                .foregroundColor(self.primaryColor)
                .padding([.top, .bottom], 12)
                .padding([.leading, .trailing], 16)
        }
    }
    
    private var primaryColor: Color {
        if self.isEnabled {
            return self.style.primaryColor
        } else {
            return .gray400
        }
    }
}

#if DEBUG
// MARK: - Previews
struct PrimaryButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            PrimaryButton(title: "Standard Button", action: {})
            PrimaryButton(title: "Standard Full Width Button",
                          fullWidth: true,
                          action: {})
            PrimaryButton(title: "Warning Button",
                          style: .warning,
                          action: {})
            PrimaryButton(title: "Warning Full Width Button",
                          style: .warning,
                          fullWidth: true,
                          action: {})
            PrimaryButton(title: "Destructive Button",
                          style: .destructive,
                          action: {})
            PrimaryButton(title: "Destructive Full Width Button",
                          style: .destructive,
                          fullWidth: true,
                          action: {})
            PrimaryButton(title: "Disabled Button", action: {})
                .disabled(true)
            PrimaryButton(title: "Disabled Full Width Button",
                          fullWidth: true,
                          action: {})
                .disabled(true)
        }.padding(20)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Title2Text("Secondary")
            SecondaryButton(title: "Standard Button", action: {})
            SecondaryButton(title: "Standard Full Width Button",
                            fullWidth: true,
                            action: {})
            SecondaryButton(title: "Warning Button",
                            style: .warning,
                            action: {})
            SecondaryButton(title: "Warning Full Width Button",
                            style: .warning,
                            fullWidth: true,
                            action: {})
            SecondaryButton(title: "Destructive Button",
                            style: .destructive,
                            action: {})
            SecondaryButton(title: "Destructive Full Width Button",
                            style: .destructive,
                            fullWidth: true,
                            action: {})
            SecondaryButton(title: "Disabled Button",
                            action: {})
                .disabled(true)
            SecondaryButton(title: "Disabled Full Width Button",
                            fullWidth: true,
                            action: {})
                .disabled(true)
        }.padding(20)
    }
}

struct TertiaryButtonPreviews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            TertiaryButton(title: "Standard Button", action: {})
            TertiaryButton(title: "Warning Button",
                           style: .warning,
                           action: {})
            TertiaryButton(title: "Destructive Button",
                           style: .destructive,
                           action: {})
            TertiaryButton(title: "Disabled Button", action: {})
                .disabled(true)
        }.padding(20)
    }
}
#endif
