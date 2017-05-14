import PackageDescription

let package = Package(
    name: "TestNunchuck",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/uraimo/Nunchuck.swift.git",
                 majorVersion: 1)
    ]
)
