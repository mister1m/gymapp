//
//  ContentViewModel.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        let cancellable = AuthService.shared.$userSession.assign(to: \.userSession, on: self)
        cancellables.insert(cancellable)
    }
}
