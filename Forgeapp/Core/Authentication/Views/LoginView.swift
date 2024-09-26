//
//  LoginView.swift
//  Testapp
//
//  Created by Lotte Faber on 19/09/2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor

struct LoginView: View {
    @State private var isPasswordVisible = false
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Spacer()
                // Logo and Welcome Text
                VStack(spacing: 8) {
                    Image(systemName: "figure.run")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.purple)
                    
                    Text("Welcome to Forge!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Your fitness journey starts here!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                
                // Email Field
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Password Field
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                // Login Button
                Button {
                    Task { try await viewModel.login()}
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                }
                
        
                // Forgot Password Link
                Button("Forgot password?") {
                    // Implement forgot password action
                }
                .foregroundStyle(.purple)
                
                Spacer()
                
                // Register Link
                NavigationLink{
                    RegistrationView()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        Text("Register").fontWeight(.semibold).foregroundStyle(.purple)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
