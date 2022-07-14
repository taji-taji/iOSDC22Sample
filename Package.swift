// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "MyExecutable",
  products: [
    .executable(name: "MyExecutable",
                targets: ["MyExecutable"])
  ],
  targets: [
    .executableTarget(
      name: "MyExecutable",
      dependencies: []),
    .testTarget(
      name: "MyExecutableTests",
      dependencies: ["MyExecutable"]),
    .plugin(
      name: "CountSwiftFiles",
      capability: .command(
        intent: .custom(verb: "count-files",
                        description: "Count Swift files"),
        permissions: []
      )
    ),
  ]
)

