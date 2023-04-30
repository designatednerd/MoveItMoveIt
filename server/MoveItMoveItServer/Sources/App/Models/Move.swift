//
//  Move.swift
//  App
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Fluent
import Vapor 

/// A single move.
final class Move: Model, Content {
    static var schema = "moves"
    
    enum DatabaseKey: String {
        case userID
        case startDate
        case endDate
    }
    
    @ID(key: .id)
    var id: UUID?
    
    /// A user that owns this ``Move`` item.
    @Parent(key: DatabaseKey.userID.fieldKey)
    var user: User
    
    /// The date that the user plans to begin their move.
    @Field(key: DatabaseKey.startDate.fieldKey)
    var startDate: Date
    
    /// [optional] The date the user plans to complete their move
    @OptionalField(key: DatabaseKey.endDate.fieldKey)
    var endDate: Date?
    
    required init() {}
    
    init(id: UUID? = UUID(),
         userID: User.IDValue,
         startDate: Date,
         endDate: Date?) {
        
        self.id = id
        self.$user.id = userID
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension Move {
    struct Migration: AsyncMigration {
        var name = "CreateMove"
        
        func prepare(on database: Database) async throws {
            try await database.schema(Move.schema)
                .id()
                .field(DatabaseKey.userID.fieldKey, .string, .required, .references(User.schema, .id))
                .field(DatabaseKey.startDate.fieldKey, .date, .required)
                .field(DatabaseKey.endDate.fieldKey, .date)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(Move.schema).delete()
        }
    }
}
