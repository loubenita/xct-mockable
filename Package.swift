// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "XCTMockable",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "XCTMockable",
            targets: [
                "XCTMockable"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        .target(
            name: "XCTMockable",
            dependencies: [
                "XCTMacros",
                "XCTBridge"
            ]
        ),
        .target(
            name: "XCTBridge",
            path: "Sources/XCTFramework/Objective-C/Bridge",
            cSettings: [.headerSearchPath("include"), .define("XCT_SWIFTPM")]
        ),
        .macro(
            name: "XCTMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .executableTarget(name: "XCTClient", dependencies: ["XCTMockable"]),
        .target(
            name: "XCTBaseTests",
            dependencies: [
                "XCTMacros",
                "XCTMockable",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ],
            path: "Tests/XCTBaseTests"
        ),
        .testTarget(
            name: "XCTMacroTests",
            dependencies: [
                "XCTBaseTests"
            ]
        ),
        .testTarget(
            name: "XCTUnitTests",
            dependencies: [
                "XCTBaseTests"
            ]
        ),
    ]
)
