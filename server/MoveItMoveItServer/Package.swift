// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoveItMoveItServer",
    platforms: [
        // Minimum supported version for Vapor
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "MoveItMoveItServer",
            targets: ["App"]),
    ],
    dependencies: [
        // The main GraphQL Dependency
        .package(url: "https://github.com/alexsteinerde/graphql-kit.git",
                 .upToNextMajor(from: "2.0.0")),
        
        // Something to help visualize and test your schema and operations
        .package(url: "https://github.com/alexsteinerde/graphiql-vapor.git",
                 .upToNextMajor(from: "2.0.0")),
        
        // These all get pulled automatically with GraphQL kit, but you need to explicitly declare them as dependencies to use them directly. 
        .package(url: "https://github.com/vapor/vapor.git",
                 .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/vapor/fluent.git",
                 .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git",
                 .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/GraphQLSwift/Graphiti", .upToNextMinor(from: "0.26.0")),
    ],
    targets: [
        // The server itself
        .executableTarget(
            name: "Run",
            dependencies: [
                "App"
            ]),
        .target(name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "GraphQLKit", package: "graphql-kit"),
                .product(name: "GraphiQLVapor", package: "graphiql-vapor"),
            ]),
        // The tests
        .testTarget(
            name: "MoveItMoveItServerTests",
            dependencies: ["Run", "App"]),
    ]
)
