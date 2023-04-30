//
//  MoveResolver.swift
//  App
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Graphiti
import Vapor
import Fluent

struct MoveIDArguments: Codable {
    /// The ID of the move to use for this operation
    let moveID: UUID
}

struct CreateMoveArguments: Codable {
    let userID: UUID
    let startDate: Date
    let endDate: Date?
}

class MoveResolver {
    
    private let userResolver = UserResolver()
    
    // MARK: - Pass-Through Methods
    
    // These are necessary because `Field` can't resolve
    // these methods properly if they're on a different object
    
    /// Creates a new user if one with that email doesn't already exist
    /// - Parameters:
    ///   - request: The request to use
    ///   - arguments: The ``UserArguments`` to use
    /// - Returns: The created user. 
    func createUser(request: Request,
                    arguments: UserCreateArguments) throws -> EventLoopFuture<User> {
       try userResolver.createUser(request: request,
                                arguments: arguments)
    }
    
    func logInUser(request: Request,
                   arguments: LoginArguments) throws -> EventLoopFuture<User> {
        try userResolver.logInUser(request: request,
                                   arguments: arguments)
    }
    
    // MARK: - Moves
    
    func createMove(request: Request,
                    arguments: CreateMoveArguments) -> EventLoopFuture<Move> {
        let move = Move(userID: arguments.userID,
                        startDate: arguments.startDate,
                        endDate: arguments.endDate)
        return move.create(on: request.db).map { move }
    }
    
    func allMoves(request: Request,
                  arguments: UserIDArgument) throws -> EventLoopFuture<[Move]> {
        return Move.query(on: request.db)
            .filter(\Move.$user.$id == arguments.userID)
            .sort(\.$startDate)
            .all()
    }
    
    func move(request: Request,
              arguments: MoveIDArguments) throws -> EventLoopFuture<Move> {
        Move
            .find(arguments.moveID, on: request.db)
            .unwrap(or: Abort(.notFound))
    }
}
