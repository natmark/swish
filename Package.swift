// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swish",
    platforms: [
        .macOS(.v10_13),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "swish",
            dependencies: []),
        .testTarget(
            name: "swishTests",
            dependencies: ["swish"]),
    ]
)
