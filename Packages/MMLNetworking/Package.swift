// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLNetworking",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(name: "MMLNetworking", targets: ["MMLNetworking"])
    ],
    dependencies: [
        .package(path: "../MMLCore")
    ],
    targets: [
        .target(name: "MMLNetworking", dependencies: ["MMLCore"]),
        .testTarget(name: "MMLNetworkingTests", dependencies: ["MMLNetworking"])
    ],
    swiftLanguageModes: [.v6]
)
