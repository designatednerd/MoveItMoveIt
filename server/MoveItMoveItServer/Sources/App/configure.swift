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
    
    // Enable Apollo Studio to access the API using CORS
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .custom("https://studio.apollographql.com"),
        allowedMethods: [.POST],
        allowedHeaders: [
            .accept,
            .contentType,
            .accessControlAllowOrigin,
            .origin
        ]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(cors)

    // Register the schema and its resolver.
    app.register(graphQLSchema: movingSchema,
                 withResolver: GraphQLResolver())

    // Enable GraphiQL web page for built-in goodness
    if !app.environment.isRelease {
        app.enableGraphiQL()
    }
}
