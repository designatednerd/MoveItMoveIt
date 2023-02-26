// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ComponentLibrary",
    platforms: [
        // 2022-2023 newest releases
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "ComponentLibrary",
            targets: ["ComponentLibrary"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ComponentLibrary",
            dependencies: []),
        .testTarget(
            name: "ComponentLibraryTests",
            dependencies: ["ComponentLibrary"]),
    ]
)
