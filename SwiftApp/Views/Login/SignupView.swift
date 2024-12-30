//
//  SignupView.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

//
//  LoginView.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            // Login Button
            PrimaryButton(title: "Sign Up") {
                viewModel.signUp()
            }.frame(width: UIScreen.main.bounds.width * 0.3)
            Button(action: { dismiss() }) {
                Text("Back to login")
            }.foregroundColor(Colors.textSecondary)
           
 

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
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    SignupView()
}
