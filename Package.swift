// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SimpleQuick",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(name: "SimpleQuick", targets: ["SimpleQuick"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
    ],
    targets: {
        var targets: [Target] = [
            .testTarget(
                name: "SimpleQuickTests",
                dependencies: [ "SimpleQuick", "Nimble" ],
                exclude: [
                    "QuickAfterSuiteTests/AfterSuiteTests+ObjC.m",
                    "QuickFocusedTests/FocusedTests+ObjC.m",
                    "QuickTests/FunctionalTests/ObjC",
                    "QuickTests/Helpers/QCKSpecRunner.h",
                    "QuickTests/Helpers/QCKSpecRunner.m",
                    "QuickTests/Helpers/QuickTestsBridgingHeader.h",
                    "QuickTests/QuickConfigurationTests.m",
                    "QuickFocusedTests/Info.plist",
                    "QuickTests/Info.plist",
                    "QuickAfterSuiteTests/Info.plist",
                ]
            ),
            .testTarget(
                name: "QuickIssue853RegressionTests",
                dependencies: [ "SimpleQuick" ]
            ),
        ]
        targets.append(contentsOf: [
            .target(
                name: "SimpleQuick",
                dependencies: [],
                exclude: [
                    "Info.plist"
                ]
            ),
        ])
        return targets
    }(),
    swiftLanguageVersions: [.v5]
)

