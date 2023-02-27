//
//  TextInput.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

public enum FieldState {
    case standard
    case active
    case error
    case disabled
    
    var decorationColor: Color {
        switch self {
        case .standard:
            return .gray800
        case .active:
            return .purple500
        case .error:
            return .red500
        case .disabled:
            return .gray400
        }
    }
}

/// An input
public struct TextInput: View {
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.isFocused) var isFocused
    @State var isActive: Bool
    let fieldName: any StringProtocol
    let helperText: (any StringProtocol)?
    var isValid: Binding<Bool?>
    var inputText: Binding<String>
    let isSecure: Bool
    @State var showText: Bool
    
    public init(fieldName: any StringProtocol,
                helperText: (any StringProtocol)?,
                isValid: Binding<Bool?>,
                inputText: Binding<String>,
                isSecure: Bool = false,
                isInitiallyActive: Bool = false) {
        self.fieldName = fieldName
        self.helperText = helperText
        self.isValid = isValid
        self.inputText = inputText
        self.isSecure = isSecure
        self._showText = State(initialValue: !isSecure)
        self._isActive = State(initialValue: isInitiallyActive)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if !self.inputText.wrappedValue.isEmpty {
                Caption1Text(self.fieldName)
                    .foregroundColor(self.state().decorationColor)
            }
            ZStack(alignment: .trailing) {
                if self.showText {
                    TextField(self.fieldName, text: self.inputText, onEditingChanged: { editing in
                        self.isActive = editing
                    })
                } else {
                    SecureTextField(titleKey: self.fieldName, text: self.inputText) { editing in
                        self.isActive = editing
                    }
                }
            }
            Rectangle()
                .fill(self.state().decorationColor)
                .frame(maxWidth: .infinity, maxHeight: 2)
                
            if let helper = self.helperText {
                Caption2Text(helper)
                    .foregroundColor(self.state().decorationColor)
            }
            
        }
    }
    
    private func state() -> FieldState {
        if self.isEnabled {
            if self.isActive {
                return .active
            }
            
            if let valid = self.isValid.wrappedValue,
               !valid {
                return .error
            }
            
            return .standard
        } else {
            return .disabled
        }
    }
}

#if DEBUG
struct WrappedFocusInput: View {
    @State var inputText: String = "Test"
    @State var isValid: Bool?
    
    let fieldName: any StringProtocol
    let helperText: (any StringProtocol)?
    let isInitiallyActive: Bool
    let isSecure: Bool
    
    public init(fieldName: any StringProtocol,
                helperText: (any StringProtocol)?,
                isSecure: Bool = false,
                isInitiallyActive: Bool = false,
                isValid: Bool? = nil) {
        self.fieldName = fieldName
        self.helperText = helperText
        self.isSecure = isSecure
        self.isInitiallyActive = isInitiallyActive
        self._isValid = State(initialValue: isValid)
    }
    
    var body: some View {
        TextInput(fieldName: self.fieldName,
                  helperText: self.helperText,
                  isValid: self.$isValid,
                  inputText: self.$inputText,
                  isSecure: self.isSecure,
                  isInitiallyActive: self.isInitiallyActive)
    }
    
}

struct TextInput_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: 20) {
            WrappedFocusInput(fieldName: "Standard input",
                              helperText: "This is what a standard input would look like")
            WrappedFocusInput(fieldName: "Active Input",
                              helperText: "This is what an active input would look like",
                              isInitiallyActive: true)
            WrappedFocusInput(fieldName: "Secure input",
                              helperText: "This should show some dots",
                              isSecure: true)
            WrappedFocusInput(fieldName: "Error Input",
                              helperText: "This is what an error input would look like",
                              isValid: false)
            TextInput(fieldName: "Disabled input",
                      helperText: "This is what a disabled input would look like",
                      isValid: .constant(true),
                      inputText: .constant(""))
            .disabled(true)
            
        }
        .padding(20)
    }
}
#endif
