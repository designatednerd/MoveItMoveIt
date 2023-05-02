//
//  GraphQLResolver+User.swift//  App
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Graphiti
import Vapor
import Fluent

struct UserCreateArguments: Codable {
    /// The user's name
    let name: String
    
    /// The email associated with the user
    let email: String
    
    /// The user's password
    let password: String
}

struct LoginArguments: Codable {
    /// The email associated with the user
    let email: String
    
    /// The user's password
    let password: String
}

struct UserIDArgument: Codable {
    /// The ID of the user to use for this operation.
    let userID: UUID
}

protocol UserResolver {
    func createUser(request: Request,
                    arguments: UserCreateArguments) throws -> EventLoopFuture<User>
    
    func logInUser(request: Request,
                   arguments: LoginArguments) throws -> EventLoopFuture<User>
}

extension UserResolver {
    
    func createUser(request: Request,
                    arguments: UserCreateArguments) throws -> EventLoopFuture<User> {
        let user = try User(email: arguments.email,
                            password: arguments.password,
                            name: arguments.name)
        return user.create(on: request.db).map { user }
    }
    
    func logInUser(request: Request,
                   arguments: LoginArguments) throws -> EventLoopFuture<User> {
        return User.query(on: request.db)
            .filter(\.$email == arguments.email)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { (user: User) in
                let valid = try Bcrypt.verify(arguments.password, created: user.hashedPassword)
                if valid {
                    return user
                } else  {
                    throw Abort(.unauthorized)
                }
            }
    }
}
