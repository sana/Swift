// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonMarkSwift",
    products: [
        .library(name: "CommonMarkSwift", targets: ["CommonMarkSwift"])
    ],
    dependencies: [
      .package(url: "https://github.com/sana/Ccmark", .branch("master")),
    ],
    targets: [
        .target(name: "CommonMarkSwift"),
        .testTarget(
            name: "CommonMarkSwiftTests",
            dependencies: ["CommonMarkSwift"]
        )
    ]
)
