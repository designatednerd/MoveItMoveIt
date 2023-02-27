//
//  Backgrounds.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Foundation
import SwiftUI

public struct BorderInfo {
    public let color: Color
    public let width: CGFloat
    
    public init(color: Color, width: CGFloat) {
        self.color = color
        self.width = width
    }
}

struct RoundedCornerBackgroundModifier: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let borderInfo: BorderInfo?
    
    init(backgroundColor: Color,
         cornerRadius: CGFloat,
         borderInfo: BorderInfo? = nil) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderInfo = borderInfo
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .fill(self.backgroundColor)
                    .ifLet(self.borderInfo, transform: { view, border in
                        view.roundedBorder(border, radius: self.cornerRadius)
                    })
            )
    }
}

public extension View {
    
    
    /// Overlays a rounded rectangle border.
    ///
    /// - Parameters:
    ///   - borderInfo: The border information to use to display the border
    ///   - radius: The corner radius of the rectangle to display
    /// - Returns: The modified view
    func roundedBorder(_ borderInfo: BorderInfo, radius: CGFloat) -> some View {
        self.overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderInfo.color, lineWidth: borderInfo.width)
            )
    }
    
    /// Applies a background with rounded corners to the given item, and optionally adds a border.
    /// - Parameters:
    ///   - background: The background color to apply
    ///   - radius: The corner radius of the border to apply
    ///   - borderInfo: [optional] Information about a border that should be overlaid, if you want it. Defaults to `nil`.
    /// - Returns: The modified view.
    func roundedCornerBackground(_ color: Color,
                                 radius: CGFloat,
                                 borderInfo: BorderInfo? = nil) -> some View {
        self.modifier(RoundedCornerBackgroundModifier(backgroundColor: color,
                                                      cornerRadius: radius,
                                                      borderInfo: borderInfo))
    }
}

#if DEBUG
struct Borders_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello background")
                .foregroundColor(.white)
                .padding()
                .roundedCornerBackground(.red500, radius: 5)
            Text("Hello border")
                .padding()
                .roundedBorder(BorderInfo(color: .red500, width: 4),
                               radius: 10)
            Text("Hello both")
                .padding()
                .roundedCornerBackground(.yellow100,
                                         radius: 15,
                                         borderInfo: BorderInfo(color: .purple700, width: 2))
        }
            
    }
}
#endif
