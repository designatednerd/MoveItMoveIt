//
//  LoginView.swift
//  MoveItMoveIt
//
//  Created by Ellen Shapiro on 2/26/23.
//

import SwiftUI

import ComponentLibrary

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            LargeTitleText("Log in")
            
            Spacer()
            
            TextInput(fieldName: "Username",
                      helperText: nil,
                      isValid: $vm.isUsernameValid,
                      inputText: $vm.username)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .textContentType(.emailAddress)

            TextInput(fieldName: "Password",
                      helperText: "Must be at least 5 characters long with at least 1 capital letter and 1 number",
                      isValid: $vm.isPasswordValid,
                      inputText: $vm.password,
                      isSecure: true)
            .autocorrectionDisabled(true)
            .textContentType(.password)
            .textInputAutocapitalization(.never)
            
            PrimaryButton(title: "Log in",
                          fullWidth: true) {
                print("Log in!")
            }
            .disabled(vm.allInputValid == false)
            
            Spacer()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    self.dismiss()
                }
            }
        })
        .padding(20)
    }
    

}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
        }
    }
}
#endif
