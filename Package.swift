// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Bivrost",
    products: [
        .executable(name: "bivrost", targets: ["Bivrost"]),
        .library(name: "BivrostKit", targets: ["BivrostKit"])
    ],
    dependencies: [
        // CryptoSwift fork including Keccak in master
        .package(url: "https://github.com/zweigraf/CryptoSwift.git", .revision("fdd115318528c9c25a06c0a89553f71bde7233da")),
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.0.2")),
        .package(url: "https://github.com/Quick/Quick.git", .revision("c498edf4aabb694a5b8a861ec3d69f0c5ab57d9e")),
        .package(url: "https://github.com/kylef/Commander.git", .revision("e0cbee1bd73778c1076c675eaf660e97d09f3b32")),
        // PathKit fork supporting SPM4
        .package(url:"git@github.com:PoissonBallon/PathKit.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Bivrost",
            dependencies: [
                "BivrostKit",
                "Commander",
                "PathKit"
            ]
        ),
        .target(
            name: "BivrostKit",
            dependencies: [
                "CryptoSwift",
                "BigInt",
                "PathKit"
            ]
        ),
        .testTarget(
            name: "BivrostKitTests",
            dependencies: [
                "BivrostKit",
                "Quick",
                "Nimble"
            ]
        )
    ],
    swiftLanguageVersions: [4]
)
