//
//  LogicalViewModifiers.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Foundation
import SwiftUI

public extension View {

    /// Applies the given transform if the given condition evaluates to `true`.
    ///
    /// (via https://www.avanderlee.com/swiftui/conditional-view-modifier/)
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform if the given optional unwraps
    ///
    /// - Parameters:
    ///   - optional: The optional of type `Data` to evaluate.
    ///   - transform: The transform to apply to the source `View`, with the unwrapped `Data`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func ifLet<Content: View, Data>(_ optional: Optional<Data>, transform: (Self, Data) -> Content) -> some View {
        if let data = optional {
            transform(self, data)
        } else {
            self
        }
    }
}
