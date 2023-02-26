//
//  Typography.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Foundation
import SwiftUI

/// Helpers to access specific fonts and tie them to system text styles
extension Font {
    static func futuraBold(_ size: CGFloat,
                           relativeTo textStyle: TextStyle) -> Font {
        Font.custom("Futura-Bold",
                    size: size,
                    relativeTo: textStyle)
    }
    
    static func futuraMedium(_ size: CGFloat,
                             relativeTo textStyle: TextStyle) -> Font {
        Font.custom("Futura-Medium",
                    size: size,
                    relativeTo: textStyle)
    }
    
    static func helveticaNeueRegular(_ size: CGFloat,
                                     relativeTo textStyle: TextStyle) -> Font {
        Font.custom("HelveticaNeue-Light",
                    size: size,
                    relativeTo: textStyle)
    }
}

// MARK: - Text Components

/// A text view which automatically applies the `Large Title` style from the Figma file to its contents.
public struct LargeTitleText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraBold(34, relativeTo: .largeTitle))
    }
}

/// A text view which automatically applies the `Title 1` style from the Figma file to its contents.
public struct Title1Text: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraMedium(28, relativeTo: .title))
    }
}

/// A text view which automatically applies the `Title 2` style from the Figma file to its contents.
public struct Title2Text: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraMedium(22, relativeTo: .title2))
    }
}

/// A text view which automatically applies the `Title 3` style from the Figma file to its contents.
public struct Title3Text: View {
    let content: any StringProtocol
    
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public var body: some View {
        Text(self.content)
            .font(.futuraMedium(20, relativeTo: .title3))
    }
}

/// A text view which automatically applies the `Headline` style from the Figma file to its contents.
public struct HeadlineText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraBold(17, relativeTo: .headline))
    }
}

/// A text view which automatically applies the `Subhead` style from the Figma file to its contents.
public struct SubheadText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraMedium(15, relativeTo: .subheadline))
    }
}

/// A text view which automatically applies the `Callout` style from the Figma file to its contents.
public struct CalloutText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.futuraMedium(16, relativeTo: .callout))
    }
}

/// A text view which automatically applies the `Body` style from the Figma file to its contents.
public struct BodyText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.helveticaNeueRegular(16, relativeTo: .body))
    }
}

/// A text view which automatically applies the `Footnote` style from the Figma file to its contents.
public struct FootnoteText: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.helveticaNeueRegular(13, relativeTo: .footnote))
    }
}

/// A text view which automatically applies the `Caption 1` style from the Figma file to its contents.
public struct Caption1Text: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.helveticaNeueRegular(12, relativeTo: .caption))
    }
}

/// A text view which automatically applies the `Caption 2` style from the Figma file to its contents.
public struct Caption2Text: View {
    let content: any StringProtocol
    
    /// Designated initializer
    ///
    /// - Parameter content: The content you wish to display.
    public init(_ content: any StringProtocol) {
        self.content = content
    }
    
    public var body: some View {
        Text(self.content)
            .font(.helveticaNeueRegular(11, relativeTo: .caption2))
    }
}

#if DEBUG
// MARK: - Previews

struct TextViewsProvider_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 10) {
                Group {
                    LargeTitleText("Large Title")
                    Title1Text("Title 1")
                    Title2Text("Title 2")
                    Title3Text("Title 3")
                    HeadlineText("Headline")
                    SubheadText("Subhead")
                    CalloutText("Callout")
                }
                Group {
                    BodyText("Body")
                    FootnoteText("Footnote")
                    Caption1Text("Caption 1")
                    Caption2Text("Caption 2")
                }
            }
        }
    }
}
#endif





