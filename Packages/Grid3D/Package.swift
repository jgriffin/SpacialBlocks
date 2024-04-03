// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Grid3D",
    products: [
        .library(
            name: "Grid3D",
            targets: ["Grid3D"]
        ),
    ],
    targets: [
        .target(
            name: "Grid3D"),
        .testTarget(
            name: "Grid3DTests",
            dependencies: ["Grid3D"]
        ),
    ]
)
