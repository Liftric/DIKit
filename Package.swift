// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "DIKit",
    products: [
        .library(
            name: "DIKit",
            targets: ["DIKit"]
        ),
    ],
    targets: [
        .target(
            name: "DIKit",
            path: "DIKit/Sources",
            exclude: [
                "Resources"
            ]
        ),
        .testTarget(
            name: "DIKitTests",
            dependencies: ["DIKit"],
            path: "DIKit/Tests",
            exclude: [
                "Info.plist"
            ]
        ),
    ]
)
