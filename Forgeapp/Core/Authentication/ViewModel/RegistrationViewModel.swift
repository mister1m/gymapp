//
//  RegistrationViewModel.swift
//  Forgeapp
//
//  Created by Lotte Faber on 20/09/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password
        )
    }
}
