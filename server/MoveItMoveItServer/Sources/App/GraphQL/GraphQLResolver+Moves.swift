//
//  GraphQLResolver+Moves.swift
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

protocol MoveResolver {
    
    // MARK: - Moves
    
    func createMove(request: Request,
                    arguments: CreateMoveArguments) -> EventLoopFuture<Move>
    
    func allMoves(request: Request,
                  arguments: UserIDArgument) throws -> EventLoopFuture<[Move]>
    
    func move(request: Request,
              arguments: MoveIDArguments) throws -> EventLoopFuture<Move>
}
extension MoveResolver {
    
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
