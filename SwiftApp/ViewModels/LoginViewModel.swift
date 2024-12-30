//
//  LoginViewModel.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-28.
//

import Foundation
import Combine
import Firebase

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isLoginSuccessful: Bool? = nil // nil: no feedback, true: success, false: failure
    @Published var errorMessage: String? = nil

    func login() {
        guard validateInputs() else { return }
        
        // Mock login validation
        if username == "testuser" && password == "password123" {
            isLoginSuccessful = true
            errorMessage = nil
        } else {
            isLoginSuccessful = false
            errorMessage = "Invalid credentials. Try again."
        }
    }

    func signUp() {
        guard validateInputs() else { return }
        guard validateEmail() else { return }
        
        // Mock sign-up logic
        FirebaseService.shared.createUser(email: email, password: password) { result in
            switch result {
            case .success(let authDataResult):
                let userId: String = authDataResult.user.uid
                Task {
                    do {
                        try await DynamoDBService.shared.saveUser(
                            userId: userId,
                            email: self.email,
                            username: self.username
                        )
                        DispatchQueue.main.async {
                            self.isLoginSuccessful = true
                            self.errorMessage = "Sign-up successful!"
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.isLoginSuccessful = false
                            self.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                        }
                    }
                }
                print("User created with UID: \(authDataResult.user.uid)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        isLoginSuccessful = true
        errorMessage = "Sign-up successful!"
    }

    private func validateInputs() -> Bool {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Username and password cannot be empty."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    private func validateEmail() -> Bool {
        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty."
            return false
        }
        
        // Regular expression for email format
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            errorMessage = "Invalid email format."
            return false
        }
        
        // Email is valid
        errorMessage = nil
        return true
    }

}

