//
//  Schema.swift
//  
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Graphiti
import Vapor

let movingSchema = try! Schema<MoveResolver, Request> {
    Scalar(UUID.self)
    Scalar(Date.self)

    Type(User.self) {
        Field("id", at: \.id)
        Field("email", at: \.email)
        Field("name", at: \.name)
    }
    
    Type(Move.self) {
        Field("id", at: \.id)
        Field("userID", at: \.user.id)
        Field("startDate", at: \.startDate)
        Field("endDate", at: \.endDate)
    }
    
    Query {
        Field("allMoves", at: MoveResolver.allMoves) {
            Argument("id", at: \.userID)
        }
        Field("move", at: MoveResolver.move) {
            Argument("id", at: \.moveID)
        }
    }
    
    Mutation {
        Field("login", at: MoveResolver.logInUser) {
            Argument("email", at: \.email)
            Argument("password", at: \.password)
        }
        Field("createUser", at: MoveResolver.createUser) {
            Argument("name", at: \.name)
            Argument("email", at: \.email)
            Argument("password", at: \.password)
        }
    }
}
