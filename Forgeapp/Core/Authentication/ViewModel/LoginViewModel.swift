//
//  LoginViewModel.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
        
    }
}
