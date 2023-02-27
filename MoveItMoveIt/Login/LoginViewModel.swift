//
//  LoginViewModel.swift
//  MoveItMoveIt
//
//  Created by Ellen Shapiro on 2/26/23.
//

import Combine
import Foundation
import RegexBuilder

class LoginViewModel: ObservableObject {
    @Published var isUsernameValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    @Published var username: String = ""
    @Published var password: String = ""
    
    private var usernameSubscription: AnyCancellable?
    private var passwordSubscription: AnyCancellable?
    
    init() {
        self.usernameSubscription = $username.sink { username in
            self.validateUsername(username)
        }
        
        self.passwordSubscription = $password.sink { password in
            self.validatePassword(password)
        }
    }
    
    deinit {
        self.usernameSubscription = nil
        self.passwordSubscription = nil
    }
    
    var allInputValid: Bool {
        self.isUsernameValid == true && self.isPasswordValid == true
    }
    
    func validateUsername(_ username: String) {
        guard username.count >= 3 else {
            self.isUsernameValid = nil
            return
        }
        
        if username.contains("@") {
            self.isUsernameValid = true
        } else {
            self.isUsernameValid = false
        }
    }
    
    func validatePassword(_ password: String) {
        guard password.count >= 5 else {
            self.isPasswordValid = nil
            return
        }
        
        let hasUppercase = password.contains { character in
            character.isUppercase
        }
        
        let digitMatches = password.matches(of: Regex {
                OneOrMore(.digit)
            }
        )
        
        if !hasUppercase || digitMatches.isEmpty {
            self.isPasswordValid = false
        } else {
            self.isPasswordValid = true
        }
    }
}
