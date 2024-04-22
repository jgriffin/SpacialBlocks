// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "RealityUI",
    platforms: [.visionOS(.v1), .iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "RealityUI",
            targets: ["RealityUI"]
        ),
        .library(
            name: "Charts3D",
            targets: ["Charts3D"]
        ),

    ],
    targets: [
        .target(
            name: "RealityUI"
        ),
        .target(
            name: "Charts3D",
            dependencies: ["RealityUI"]
        ),
        .testTarget(
            name: "RealityUITests",
            dependencies: ["RealityUI"]
        ),
    ]
)
