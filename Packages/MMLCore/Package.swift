// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MMLCore", targets: ["MMLCore"])
    ],
    targets: [
        .target(name: "MMLCore"),
        .testTarget(name: "MMLCoreTests", dependencies: ["MMLCore"])
    ],
    swiftLanguageModes: [.v6]
)
