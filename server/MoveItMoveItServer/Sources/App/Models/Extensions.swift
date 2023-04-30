//
//  Extensions.swift
//  
//
//  Created by Ellen Shapiro on 4/30/23.
//

import Fluent

extension RawRepresentable where RawValue == String {
    var fieldKey: FieldKey {
        return .string(self.rawValue)
    }
}

