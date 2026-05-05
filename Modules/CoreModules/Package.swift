// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreModules",
    platforms: [.iOS(.v13), .macOS(.v12)],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Data", targets: ["Data"])
    ],
    targets: [
        // 1. Domain: Depends on NOTHING
        .target(
            name: "Domain",
            dependencies: []
        ),

        // 2. DataLayer: Depends on Domain (to see the protocol)
        .target(
            name: "Data",
            dependencies: ["Domain"],
            resources: [.process("Resources/MovieModel.xcdatamodeld")]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Domain"]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]
        )
    ],
    swiftLanguageModes: [.v6]
)
