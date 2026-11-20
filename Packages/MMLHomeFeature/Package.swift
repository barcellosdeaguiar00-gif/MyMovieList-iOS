// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLHomeFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MMLHomeFeature", targets: ["MMLHomeFeature"])
    ],
    dependencies: [
        .package(path: "../MMLDomain"),
        .package(path: "../MMLTheme")
    ],
    targets: [
        .target(name: "MMLHomeFeature", dependencies: ["MMLDomain", "MMLTheme"]),
        .testTarget(name: "MMLHomeFeatureTests", dependencies: ["MMLHomeFeature"])
    ],
    swiftLanguageModes: [.v6]
)
