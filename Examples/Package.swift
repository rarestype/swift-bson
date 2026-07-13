// swift-tools-version:6.2
import PackageDescription

let package: Package = .init(
    name: "swift-bson-examples",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .visionOS(.v2), .watchOS(.v11)],
    products: [
        .executable(name: "bson2json", targets: ["bson2json"]),
        .library(name: "BSON_JSON", targets: ["BSON_JSON"]),
    ],
    dependencies: [
        .package(name: "swift-bson", path: ".."),

        .package(url: "https://github.com/ordo-one/dollup", from: "1.0.8"),
        .package(url: "https://github.com/rarestype/swift-io", from: "3.4.0"),
        .package(url: "https://github.com/rarestype/swift-json", from: "3.4.4"),
    ],
    targets: [
        .executableTarget(
            name: "bson2json",
            dependencies: [
                .target(name: "BSON_JSON"),
                .product(name: "System_ArgumentParser", package: "swift-io"),
            ],
            path: "bson2json"
        ),
        .target(
            name: "BSON_JSON",
            dependencies: [
                .product(name: "BSON", package: "swift-bson"),
                .product(name: "JSON", package: "swift-json"),
            ],
            path: "BSON_JSON"
        ),
    ]
)

for target: PackageDescription.Target in package.targets {
    {
        var settings: [PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        $0 = settings
    } (&target.swiftSettings)
}
