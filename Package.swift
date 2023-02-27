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
      url: "https://github.com/alandeguz/LicensePlist/releases/download/3.24.1/LicensePlistBinary-macos.artifactbundle.zip",
      checksum: "7563512e93706fde0517abe9da1c33543a702fa455b8e6aa35181d544eea7cda"
    )
  ]
)
