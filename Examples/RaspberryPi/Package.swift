// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TestNunchuck",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/Nunchuck.swift.git",from: "2.0.0")
    ],
    targets: [
        .target(name: "TestNunchuck", 
                dependencies: ["SwiftyGPIO","Nunchuck"],
                path: "Sources")
    ]
) 