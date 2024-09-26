//
//  SettingsView.swift
//  Testapp
//
//  Created by Lotte Faber on 19/09/2024.
//

import SwiftUI


struct SettingsView: View {
    var body: some View {
        NavigationStack{
            Button {
                AuthService.shared.signOut()
            } label: {
                Text("Logout")
            }
        }
    }
}

#Preview {
    SettingsView()
}
