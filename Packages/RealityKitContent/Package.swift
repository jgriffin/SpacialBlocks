// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "RealityKitContent",
    products: [
        .library(
            name: "RealityKitContent",
            targets: ["RealityKitContent"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RealityKitContent",
            dependencies: []
        ),
        .testTarget(
            name: "RealityKitContentTests",
            dependencies: [
                "RealityKitContent",
            ]
        ),
    ]
)
