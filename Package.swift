import PackageDescription

let package = Package(
    name: "ios-viper",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/GRMustache.swift", majorVersion: 1, minor: 5),
        .Package(url: "https://github.com/kylef/Commander", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/JohnSundell/Files", majorVersion: 1, minor: 1)
    ]
)
