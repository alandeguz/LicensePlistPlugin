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
      url: "https://github.com/mono0926/LicensePlist/releases/download/3.24.9/LicensePlistBinary-macos.artifactbundle.zip",
      checksum: "57bc9aad97510ee73af979bb3a8dc63653e522dce71a505c13059ab54d6fc990"
    )
  ]
)
