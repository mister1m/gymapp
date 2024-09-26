//
//  ContentView.swift
//  Forgeapp
//
//  Created by Lotte Faber on 20/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomeTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
