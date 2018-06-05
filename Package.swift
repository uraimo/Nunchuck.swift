import PackageDescription

let package = Package(
    name: "Nunchuck",
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git",
                 majorVersion: 1)
    ]
)
