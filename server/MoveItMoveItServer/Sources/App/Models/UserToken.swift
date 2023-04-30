//
//  UserToken.swift
//  App
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Fluent
import Vapor

final class UserToken: Model, Content {
    static let schema = "user_tokens"
    
    enum DatabaseKey: String {
        case value
        case userID
    }

    @ID(key: .id)
    var id: UUID?

    @Field(key: DatabaseKey.value.fieldKey)
    var value: String

    @Parent(key: DatabaseKey.userID.fieldKey)
    var user: User

    init() { }

    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user

    var isValid: Bool {
        true
    }
}

extension UserToken {
    struct Migration: AsyncMigration {
        var name = "CreateUserToken"

        func prepare(on database: Database) async throws {
            try await database.schema(UserToken.schema)
                .id()
                .field(DatabaseKey.value.fieldKey, .string, .required)
                .field(DatabaseKey.userID.fieldKey, .uuid, .required, .references(User.schema, .id))
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(UserToken.schema).delete()
        }
    }
}
