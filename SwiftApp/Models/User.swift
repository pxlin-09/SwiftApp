//
//  User.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-28.
//

import Foundation
struct User: Codable {
    let id: UUID
    var username: String
    var email: String
    var name: String
    var profilePictureURL: String?
    var bio: String?
    var preferences: Preferences?

    struct Preferences: Codable {
        var notificationsEnabled: Bool
        var theme: String
    }
}
