// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Bivrost",
    products: [
        .executable(name: "bivrost", targets: ["Bivrost"]),
        .library(name: "BivrostBase", targets: ["BivrostBase"])
    ],
    dependencies: [
        // CryptoSwift fork including Keccak in master
        .package(url: "https://github.com/zweigraf/CryptoSwift.git", .revision("fdd115318528c9c25a06c0a89553f71bde7233da")),
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.2")),
        .package(url: "https://github.com/Quick/Quick.git", .revision("c498edf4aabb694a5b8a861ec3d69f0c5ab57d9e")),
        .package(url: "https://github.com/kylef/Commander.git", .revision("e0cbee1bd73778c1076c675eaf660e97d09f3b32")),
        // PathKit fork supporting SPM4
        .package(url: "https://github.com/PoissonBallon/PathKit.git", .revision("0b109bc868e9a12bc5f23e9d61ec937c75900c40"))
    ],
    targets: [
        .target(
            name: "Bivrost",
            dependencies: [
                "BivrostBase",
                "Commander",
                "PathKit"
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
