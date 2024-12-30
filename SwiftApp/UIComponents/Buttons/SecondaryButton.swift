//
//  PrimaryButton.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(Colors.primary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Colors.primary, lineWidth: 1)
                )
        }
    }
}



#Preview {
    SecondaryButton(title: "Get Started") {
        print("Button Tapped")
    }
}
