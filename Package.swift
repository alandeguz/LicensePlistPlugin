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
      url: "https://github.com/alandeguz/LicensePlist/releases/download/3.24.3/LicensePlistBinary-macos.artifactbundle.zip",
      checksum: "d4c0c67b38ba3d80fa4e75b1693639e51245044cdc222ec4fb1d82584b3ec035"
    )
  ]
)
