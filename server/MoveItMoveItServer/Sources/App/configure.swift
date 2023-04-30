//
//  configure.swift
//  App
//
//  Created by Ellen Shapiro on 4/9/23.
//

import Foundation

import GraphQL
import FluentSQLiteDriver
import Vapor
import GraphQLKit
import GraphiQLVapor

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    // Create the appropriate migrations
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    app.migrations.add(Move.Migration())
    
    try app.autoMigrate().wait()

    // Register the schema and its resolver.
    app.register(graphQLSchema: movingSchema,
                 withResolver: MoveResolver())


    let tokenProtected = app.grouped(UserToken.authenticator())



    // Enable GraphiQL web page to send queries to the GraphQL endpoint
    if !app.environment.isRelease {
        app.enableGraphiQL()
    }
}
