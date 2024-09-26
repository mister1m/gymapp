//
//  AuthService.swift
//  Forgeapp
//
//  Created by Lotte Faber on 21/09/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class AuthService {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // sign us out on backend
        self.userSession = nil // this removes session locally and update routing
    }
    
    @MainActor
    private func uploadUserData(
        withEmail email: String,
        id: String
    ) async throws {
        let user = User(id: id, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else {return}
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
}
