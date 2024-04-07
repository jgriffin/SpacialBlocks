// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Grid3D",
    platforms: [.visionOS(.v1)],
    products: [
        .library(
            name: "Grid3D",
            targets: ["Grid3D"]
        ),
        .library(
            name: "Charts3D",
            targets: ["Charts3D"]
        ),

    ],
    targets: [
        .target(
            name: "Grid3D"),
        .testTarget(
            name: "Grid3DTests",
            dependencies: ["Grid3D"]
        ),

        .target(
            name: "Charts3D"),
        .testTarget(
            name: "Charts3DTests",
            dependencies: ["Charts3D"]
        ),
    ]
)
