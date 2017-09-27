import PackageDescription

let package = Package(
    name: "BivrostFramework",
    dependencies: [
        .Package(url: "https://github.com/zweigraf/CryptoSwift.git", majorVersion: 0),
        .Package(url: "https://github.com/attaswift/BigInt.git", majorVersion: 3)
    ]
)