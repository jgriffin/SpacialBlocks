// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Charts3D",
    platforms: [.visionOS(.v1)],
    products: [
        .library(
            name: "Charts3D",
            targets: ["Charts3D"]
        ),
    ],
    targets: [
        .target(
            name: "Charts3D"),
        .testTarget(
            name: "Charts3DTests",
            dependencies: ["Charts3D"]
        ),
    ]
)
