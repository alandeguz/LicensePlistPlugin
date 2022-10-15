//
//  LicensePlistBuildToolPlugin.swift
//  Plugins/LicensePlist
//
//  Created by Alan DeGuzman on 9/23/22.
//

import Foundation
import PackagePlugin

@main

// for operating on a Swift package
struct LicensePlistBuildToolPlugin: BuildToolPlugin {
  
  // disabled as plugin intended only for Xcode projects
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    return [
      .buildCommand(
        displayName: "\(Const.skipFor) \(target.name)",
        executable: Const.doNothing,
        arguments: [],
        environment: [:]
      )
    ]
  }
  
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

// for operating on an Xcode project
extension LicensePlistBuildToolPlugin: XcodeBuildToolPlugin {
  
  func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
    let configPath = context.xcodeProject.directory.appending(subpath: Const.configFileName)
    let config = try Config.parseConfig(configPath.string)
    
    // skip if the `environmentVarDoNotExecute` exists
    if let ciEnvironment = config.environmentVarDoNotExecute,
       let env = ProcessInfo.processInfo.environment[ciEnvironment],
       !env.isEmpty {
      return [
        .buildCommand(
          displayName: "\(Const.skipFor) \(target.displayName)",
          executable: Const.doNothing,
          arguments: [],
          environment: [:]
        )
      ]
    }
    
    // only execute on non-CI builds
    return [
      try licenseplist(context: context, target: target)
    ]
  }
  
  func licenseplist(context: XcodePluginContext, target: XcodeTarget) throws -> Command {
    let configPath = context.xcodeProject.directory.appending(subpath: Const.configFileName)
    let config = try Config.parseConfig(configPath.string)
    let arguments = config.arguments(context.xcodeProject.directory)
    
    return
      .prebuildCommand(
        displayName: "Running LicensePlist...",
        executable: try context.tool(named: "license-plist").path,
        arguments: arguments,
        environment: [: ],
        outputFilesDirectory: context.pluginWorkDirectory
      )
  }
  
}

/*
 The `license-plist` binary doesn't support any type of configuration file, and instead expects all values to be passed as arguments. Therefore, we'll define our own config file as a property list (to leverage the native PropertyListDecoder), and construct the sequence of arguments to the binary in code.
 
 Presumably a future version of license-plist could support a config file, and this code would go away.
 */

struct Config: Codable {
  let carfilePath: String?
  let mintfilePath: String?
  let podsPath: String?
  let packagePath: String?
  let packagesPath: String?
  let xcodeprojPath: String?
  let xcworkspacePath: String?
  let outputPath: String?
  let githubToken: String?
  let configPath: String?
  let prefix: String?
  let htmlPath: String?
  let markdownPath: String?
  let force: Bool?
  let addVersionNumbers: Bool?
  let addSources: Bool?
  let supressOpeningDirectory: Bool?
  let singlePage: Bool?
  let failIfMissingLicense: Bool?
  
  // Some build services (like Bitrise) block the execution of plugins that make netwwork calls.
  // This flag checks if a specific environment variable is set. If it is set, then the plugin
  // does not execute.
  let environmentVarDoNotExecute: String?
  
  static func parseConfig(_ path: String) throws -> Config  {
    guard let file = FileManager.default.contents(atPath: path) else {
      throw URLError(URLError.Code(rawValue: NSURLErrorFileDoesNotExist))
    }
    return try PropertyListDecoder().decode(Config.self, from: file)
  }
  
  func arguments(_ dir: PackagePlugin.Path) -> [String] {
    var strings: [String] = []
    strings.append(contentsOf: dir.format("--cartfile-path", carfilePath))
    strings.append(contentsOf: dir.format("--mintfile-path", mintfilePath))
    strings.append(contentsOf: dir.format("--pods-path", podsPath))
    strings.append(contentsOf: dir.format("--package-path", packagePath))
    strings.append(contentsOf: dir.format("--packages-path", packagesPath))
    strings.append(contentsOf: dir.format("--xcodeproj-path", xcodeprojPath))
    strings.append(contentsOf: dir.format("--xcworkspace-path", xcworkspacePath))
    strings.append(contentsOf: dir.format("--output-path", outputPath))
    strings.append(contentsOf: dir.format("--config-path", configPath))
    strings.append(contentsOf: format("--prefix", prefix))
    strings.append(contentsOf: dir.format("--html-path", htmlPath))
    strings.append(contentsOf: dir.format("--markdown-path", markdownPath))
    
    var bools: [String] = []
    bools.append(contentsOf: format("--force", force))
    bools.append(contentsOf: format("--add-version-numbers", addVersionNumbers))
    bools.append(contentsOf: format("--add-sources", addSources))
    bools.append(contentsOf: format("--suppress-opening-directory", supressOpeningDirectory))
    bools.append(contentsOf: format("--single-page", singlePage))
    bools.append(contentsOf: format("--fail-if-missing-license", failIfMissingLicense))
    
    return bools + strings
  }
  
  func format(_ key: String, _ val: String?) -> [String] {
    if let val = val, !val.isEmpty {
      return [key, val]
    }
    return []
  }
  
  func format(_ key: String, _ bool : Bool?) -> [String] {
    if let bool = bool, bool {
      return [key]
    }
    return []
  }
}

extension PackagePlugin.Path {
  
  func format(_ key: String, _ subPath: String?) -> [String] {
    if let subPath = subPath, !subPath.isEmpty {
      return [key, appending(subpath: subPath).string]
    }
    return []
  }
  
}

#endif

enum Const {
  static let doNothing = PackagePlugin.Path("/usr/bin/true")
  static let skipFor = "Skipping LicensePlist for"
  static let configFileName = "license-plist-config.plist"
}
