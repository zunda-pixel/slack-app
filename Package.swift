// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "SlackApp",
  platforms: [
    .iOS(.v26),
    .macOS(.v26),
  ],
  products: [
    .library(
      name: "SlackApp",
      targets: ["SlackApp"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect.git", from: "1.4.0-beta.2"),
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
