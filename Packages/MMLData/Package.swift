// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLData",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(name: "MMLData", targets: ["MMLData"])
    ],
    dependencies: [
        .package(path: "../MMLDomain"),
        .package(path: "../MMLNetworking")
    ],
    targets: [
        .target(name: "MMLData", dependencies: ["MMLDomain", "MMLNetworking"]),
        .testTarget(name: "MMLDataTests", dependencies: ["MMLData"])
    ],
    swiftLanguageModes: [.v6]
)
