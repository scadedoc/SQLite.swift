// swift-tools-version:5.3
import PackageDescription

let applePlatforms: [Platform] = [.macOS, .iOS, .tvOS, .watchOS]

let package = Package(
    name: "SQLite.swift",
    products: [.library(name: "SQLite", targets: ["SQLite"])],
    targets: [
        .target(
            name: "SQLite",
            dependencies: [
                .target(name: "SQLiteObjc", condition: .when(platforms: applePlatforms))
            ],
            swiftSettings: [
                .define("ENABLE_APPLE_EXTENSIONS", .when(platforms: applePlatforms))
            ]
        ),
        .target(name: "SQLiteObjc"),
        .testTarget(
            name: "SQLiteTests",
            dependencies: ["SQLite"],
            path: "Tests/SQLiteTests",
            swiftSettings: [
                .define("ENABLE_APPLE_EXTENSIONS", .when(platforms: applePlatforms))
            ]
        )
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)

//#if os(Linux)
//    package.dependencies = [.package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")]
//    package.targets = [
//        .target(name: "SQLite", exclude: ["Extensions/FTS4.swift", "Extensions/FTS5.swift"]),
//        .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests", exclude: [
//            "FTS4Tests.swift",
//            "FTS5Tests.swift"
//        ])
//    ]
//#endif
