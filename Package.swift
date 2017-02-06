import PackageDescription

let package = Package(
    name: "ios-viper",
    dependencies: [
        .Package(url: "https://github.com/oarrabi/Guaka.git", majorVersion: 0),
        .Package(url: "https://github.com/IBM-Swift/GRMustache.swift", majorVersion: 1),
        .Package(url: "https://github.com/JohnSundell/Files", majorVersion: 1),
        .Package(url: "https://github.com/oarrabi/FileUtils.git", majorVersion: 0),
    ]
)
