// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "RealityUI",
    products: [
        .library(
            name: "RealityUI",
            targets: ["RealityUI"]
        ),
    ],
    targets: [
        .target(
            name: "RealityUI"),
        .testTarget(
            name: "RealityUITests",
            dependencies: ["RealityUI"]
        ),
    ]
)
