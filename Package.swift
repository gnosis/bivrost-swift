// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "BivrostFramework",
    products: [
        .executable(name: "Bivrost", targets: ["Bivrost"]),
        .library(name: "BivrostBase", targets: ["BivrostBase"])
    ],
    dependencies: [
        .package(url: "https://github.com/zweigraf/CryptoSwift.git", .revision("fdd115318528c9c25a06c0a89553f71bde7233da")),
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.2")),
        .package(url: "https://github.com/Quick/Quick.git", .revision("c498edf4aabb694a5b8a861ec3d69f0c5ab57d9e"))
    ],
    targets: [
        .target(
            name: "Bivrost",
            dependencies: [
                "BivrostBase"
            ]
        ),
        .target(
            name: "BivrostBase",
            dependencies: [
                "CryptoSwift",
                "BigInt"
            ]
        ),
        .testTarget(
            name: "BivrostBaseTests",
            dependencies: [
                "BivrostBase",
                "Quick",
                "Nimble"
            ]
        )
    ],
    swiftLanguageVersions: [4]
)