// swift-tools-version: 6.4

import PackageDescription

let package = Package(
  name: "SlackApp",
  platforms: [
    .iOS(.v27),
    .macOS(.v27),
  ],
  products: [
    .library(
      name: "SlackApp",
      targets: ["SlackApp"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect.git", from: "27.0.0"),
  ],
  targets: [
    .target(
      name: "SlackApp",
      dependencies: [
        .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
      ]
    ),
    .testTarget(
      name: "SlackAppTests",
      dependencies: ["SlackApp"]
    ),
  ]
)
