//
//  User.swift
//  MoveItMoveItServer
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Fluent
import Vapor

final class User: Model, Content {
    static var schema = "users"
    
    enum DatabaseKeys: String {
        case email
        case name
        case hashedPassword
    }
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: DatabaseKeys.email.fieldKey)
    var email: String

    @Field(key: DatabaseKeys.name.fieldKey)
    var name: String
    
    @Field(key: DatabaseKeys.hashedPassword.fieldKey)
    var hashedPassword: String

    @Children(for: \.$user)
    var moves: [Move]
    
    required init() {}
    
    init(id: UUID? = UUID(),
         email: String,
         password: String,
         name: String) throws {
        self.id = id
        self.email = email
        self.name = name
        self.hashedPassword = try Bcrypt.hash(password) // not passing a salt will use a randomly generated salt
    }
    
    func generateToken() throws -> UserToken {
            try UserToken(
                value: [UInt8].random(count: 16).base64,
                userID: self.requireID()
            )
        }
}

extension User: ModelAuthenticatable {
    static var usernameKey = \User.$email
    static var passwordHashKey = \User.$hashedPassword
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.hashedPassword)
    }
}

extension User {
    struct Migration: AsyncMigration {
        var name = "CreateUser"

        func prepare(on database: Database) async throws {
            try await database.schema(User.schema)
                .id()
                .field(DatabaseKeys.name.fieldKey, .string, .required)
                .field(DatabaseKeys.email.fieldKey, .string, .required)
                .field(DatabaseKeys.hashedPassword.fieldKey, .string, .required)
                .unique(on: DatabaseKeys.hashedPassword.fieldKey)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(User.schema).delete()
        }
    }
}
