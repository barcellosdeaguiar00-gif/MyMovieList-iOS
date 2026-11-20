// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MMLDomain", targets: ["MMLDomain"])
    ],
    dependencies: [
        .package(path: "../MMLCore")
    ],
    targets: [
        .target(name: "MMLDomain", dependencies: ["MMLCore"]),
        .testTarget(name: "MMLDomainTests", dependencies: ["MMLDomain"])
    ],
    swiftLanguageModes: [.v6]
)
