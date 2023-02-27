//
//  SecureTextField.swift
//  ComponentLibrary
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

struct SecureTextField: View {
    @Environment(\.isFocused) var isFocused: Bool
    
    let titleKey: any StringProtocol
    let text: Binding<String>
    @State var showText: Bool = false
    let editingChanged: (Bool) -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if self.showText {
                TextField(self.titleKey,
                          text: self.text,
                          onEditingChanged: self.editingChanged)
            } else {
                SecureField(self.titleKey, text: self.text)
            }
            
            Button(action: {
                self.showText.toggle()
            }, label: {
                if self.showText {
                    Image(systemName: "eye.slash")
                } else {
                    Image(systemName: "eye")
                }
            })
            .foregroundColor(.gray1000)
        }
        .onChange(of: self.isFocused) { newValue in
            editingChanged(newValue)
        }
    }
}

#if DEBUG
enum EditingView: String, Hashable {
    case secure
    case securer
}

struct SecureTextFieldPreviewWrapper: View {
    @State var secureContent: String = ""
    @State var securerContent: String = ""
    
    @State var secureBorder: Color = .gray200
    @State var securerBorder: Color = .gray200
    
    @FocusState var editingView: EditingView?

    var body: some View {
        VStack {
            SecureTextField(titleKey: "secure", text: self.$secureContent, editingChanged: { isEditing in
                if isEditing {
                    self.secureBorder = .gray1000
                } else {
                    self.secureBorder = .gray200
                }
            })
            .padding(10)
            .border(self.secureBorder)
            .focused(self.$editingView, equals: .secure)
            SecureTextField(titleKey: "securer", text: self.$securerContent) { isEditing in
                if isEditing {
                    self.securerBorder = .gray1000
                } else {
                    self.securerBorder = .gray200
                }
            }
            .padding(10)
            .border(self.securerBorder)
            .focused(self.$editingView, equals: .securer)
        }
        .padding()
        .border(self.borderColor, width: 3)
        .padding(20)
        
    }
    
    var borderColor: Color {
        switch self.editingView {
        case .none:
            return .gray100
        case .secure:
            return .purple500
        case .securer:
            return .red500
        }
    }
}

struct SecureTextField_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            SecureTextFieldPreviewWrapper()
        }
    }
}
#endif
