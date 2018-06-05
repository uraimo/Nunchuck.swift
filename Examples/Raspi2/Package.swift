import PackageDescription

let package = Package(
    name: "TestNunchuck",
    dependencies: [
        .Package(url: "https://github.com/uraimo/Nunchuck.swift.git",
                 majorVersion: 2)
    ]
)
