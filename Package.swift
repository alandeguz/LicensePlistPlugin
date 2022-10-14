// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "LicensePlistPlugin",
  platforms: [
    .iOS(.v13),
    .watchOS(.v6),
    .macOS(.v10_15),
    .tvOS(.v13)
  ],
  products: [
    .plugin(name: "LicensePlist", targets: ["LicensePlistPlugin"]),
  ],
  dependencies: [],
  targets: [
    .plugin(
      name: "LicensePlistPlugin",
      capability: .buildTool(),
      dependencies: ["LicensePlistBinary"]),
    .binaryTarget(
      name: "LicensePlistBinary",
      url: "https://github.com/alandeguz/LicensePlist/releases/download/3.23.4/LicensePlistBinary-macos.artifactbundle.zip",
      checksum: "f31adf82ab57abb7d6027da383c22fdb03cf8078b42f37fe574d83e7ff5a6dd3"
    )
  ]
)
