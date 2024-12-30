//
//  DynamoCBService.swift
//  SwiftApp
//
//  Created by Alex needs to work on 2024-12-29.
//

import Foundation
import AWSClientRuntime
import AWSDynamoDB
import AWSClientRuntime

class DynamoDBService {
    static let shared = DynamoDBService()
    private let client: DynamoDBClient
    
    
    private init() {
        // Configure DynamoDB client for LocalStack
        do {
            let config = try DynamoDBClient.DynamoDBClientConfiguration(
                region: "us-east-1", // Use a mock region
                endpoint: "http://localhost:4566" // Point to LocalStack
            )
            client = DynamoDBClient(config: config)
        } catch {
            fatalError("Failed to configure DynamoDBClient: \(error.localizedDescription)")
        }
    }
    
    func saveUser(userId: String, email: String, username: String) async throws {
        guard !userId.isEmpty, !email.isEmpty, !username.isEmpty else {
            throw NSError(domain: "DynamoDBService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid input data: userId, email, and username must not be empty."])
        }

        print("Saving user with userId: \(userId), email: \(email), username: \(username)")
        let input = PutItemInput(
            item: [
                "UserId": .s("test-user-id")
                //"email": .s(email),
                //"username": .s(username)
            ],
                tableName: "Users"
            )
        print("DynamoDB PutItemInput: \(input)")

        do {
            _ = try await client.putItem(input: input)
        } catch {
            print("ERROR: add movie:", dump(error))
            throw error
        }
    }
}

