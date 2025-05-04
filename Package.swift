// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "SlackApp",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "SlackApp",
      targets: ["SlackApp"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.3.0"),
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
