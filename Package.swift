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
      checksum: "14646c7af847f65d130bf15b5ac08b5b785691739fdadcf373ea062696b24631"
    )
  ]
)
