//
//  SwiftAppApp.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-28.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct SwiftAppApp: App {
    
    init() {
        FirebaseApp.configure()
        let auth = Auth.auth()
        auth.useEmulator(withHost: "localhost", port: 9099)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
