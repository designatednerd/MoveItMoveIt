//
//  Schema.swift
//  
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Graphiti
import Vapor

let movingSchema = try! Schema<GraphQLResolver, Request> {
    Scalar(UUID.self)
    DateScalar(formatter: ISO8601DateFormatter())

    Type(User.self) {
        Field("id", at: \.id, as: UUID.self)
        Field("email", at: \.email)
        Field("name", at: \.name)
    }
    
    Type(Move.self) {
        Field("id", at: \.id, as: UUID.self)
        Field("user", at: \.user)
            .description("The user who is moving")
        Field("startDate", at: \.startDate)
            .description("The date the move will begin")
        Field("endDate", at: \.endDate)
            .description("The date the move will end, or null if unknown")
    }
    
    Query {
        Field("allMoves", at: GraphQLResolver.allMoves) {
            Argument("userID", at: \.userID)
                .description("The identifier of the user to pull a list of moves for")
        }
        .description("All the moves for the given user")
        Field("move", at: GraphQLResolver.move) {
            Argument("moveID", at: \.moveID)
        }
    }
    
    Mutation {
        Field("login", at: GraphQLResolver.logInUser) {
            Argument("email", at: \.email)
            Argument("password", at: \.password)
        }
        Field("createUser", at: GraphQLResolver.createUser) {
            Argument("name", at: \.name)
            Argument("email", at: \.email)
            Argument("password", at: \.password)
        }
        Field("createMove", at: GraphQLResolver.createMove) {
            Argument("userID", at: \.userID)
            Argument("startDate", at: \.startDate)
            Argument("endDate", at: \.endDate) 
        }
    }
}
