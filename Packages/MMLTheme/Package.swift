// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MMLTheme",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MMLTheme",
            targets: ["MMLTheme"]
        )
    ],
    targets: [
        .target(
            name: "MMLTheme",
            resources: [
                .copy("Resources/montserrat_regular.ttf"),
                .copy("Resources/montserrat_medium.ttf"),
                .copy("Resources/montserrat_semibold.ttf"),
                .copy("Resources/error_drawable.png"),
                .copy("Resources/icon_film.webp")
            ]
        )
    ]
)
