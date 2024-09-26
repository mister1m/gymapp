//
//  UserService.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

class userService {
    @Published var currentUser: User?
    
    static let shared = userService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print("DEBUG: User is \(user)")
    }
}
