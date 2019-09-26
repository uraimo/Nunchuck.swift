// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Nunchuck",
    products: [
        .library(
            name: "Nunchuck",
            targets: ["Nunchuck"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Nunchuck",
            dependencies: ["SwiftyGPIO"],
            path: ".",
            sources: ["Sources"])
    ]
)