// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Bivrost",
    products: [
        .executable(name: "bivrost", targets: ["Bivrost"]),
        .library(name: "BivrostKit", targets: ["BivrostKit"]),
        .library(name: "BivrostHelper", targets: ["BivrostHelper"])
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", .upToNextMinor(from: "0.8.0")),
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMinor(from: "7.0.2")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMinor(from: "1.2.0")),
        .package(url: "https://github.com/kylef/Commander.git", .revision("e0cbee1bd73778c1076c675eaf660e97d09f3b32")),
        // PathKit fork supporting SPM4
        .package(url: "https://github.com/PoissonBallon/PathKit.git", .branch("master")),
        // Stencil fork supporting SPM4
        .package(url: "https://github.com/zweigraf/Stencil.git", .branch("master")),
        // StencilSwiftKit fork supporting SPM4
        .package(url: "https://github.com/zweigraf/StencilSwiftKit.git", .revision("82a0099e5c446348692a2ba40ffbba980c6b8898"))
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
                "Stencil",
                "StencilSwiftKit",
                "PathKit"
            ]
        ),
        .target(
            name: "BivrostHelper",
            dependencies: [
                "BigInt"
            ]
        ),
        .testTarget(
            name: "BivrostKitTests",
            dependencies: [
                "BivrostKit",
                "Quick",
                "Nimble"
            ]
        ),
        .testTarget(
            name: "BivrostHelperTests",
            dependencies: [
                "BivrostHelper",
                "Quick",
                "Nimble"
            ]
        )
    ],
    swiftLanguageVersions: [4]
)
