//
//  LoginView.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showSignupPage = false // Local state for navigation

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Login Button
                PrimaryButton(title: "Log In") {
                    viewModel.login()
                }.frame(width: UIScreen.main.bounds.width * 0.3) // 50% of screen width
                
                
                
                VStack {
                    // Sign-up Button
                    Button(action: {showSignupPage = true}) {
                        Text("Sign Up")
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                    .foregroundColor(Colors.textSecondary)
                    
                }.navigationDestination(isPresented: $showSignupPage) {
                    SignupView() // Destination view
                }
                
                // Feedback Section
                if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                } else if let isLoginSuccessful = viewModel.isLoginSuccessful, isLoginSuccessful {
                    Text("Success!")
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }
}


#Preview {
    LoginView()
}
