//
//  PrimaryButton.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(Colors.textWhite)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Colors.primary)
                .cornerRadius(10)
        }
    }
}



#Preview {
    PrimaryButton(title: "Get Started") {
        print("Button Tapped")
    }
}
