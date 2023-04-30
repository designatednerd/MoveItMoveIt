//
//  Extensions.swift
//  
//
//  Created by Ellen Shapiro on 4/30/23.
//

import Fluent

// Allow the use of `.fieldKey` on any enum of `String` type.
extension RawRepresentable where RawValue == String {
    var fieldKey: FieldKey {
        return .string(self.rawValue)
    }
}

