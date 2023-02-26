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
                        view.overlay(
                            RoundedRectangle(cornerRadius: self.cornerRadius)
                                .stroke(border.color, lineWidth: border.width)
                        )
                        
                    })
            )
    }
}

public extension View {
    
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
            Text("Hello, world!")
                .foregroundColor(.white)
                .padding()
                .roundedCornerBackground(.red500, radius: 5)
            Text("Hello border")
                .padding()
                .roundedCornerBackground(.clear,
                                         radius: 5,
                                         borderInfo: BorderInfo(color: .red500, width: 4))
        }
            
    }
}
#endif
