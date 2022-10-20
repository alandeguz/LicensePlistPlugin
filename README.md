# LicensePlistPlugin


[![Language: Swift](https://img.shields.io/badge/language-swift-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Version: swift version 5.7](https://img.shields.io/badge/swift-5.7-F16D39.svg?style=flat)
![Platform: iOS 14.0+ macOS 12.4+](https://img.shields.io/badge/target-iOS%2013.7%2B%20macOS%2012.4%2B-blue.svg?style=flat)
[![Xcode](https://img.shields.io/badge/Xcode-14+-007ACC?style=&logo=Xcode&logoColor=white)](https://developer.apple.com/xcode/)

A Swift package plugin implementation for `LicensePlist`

* [Summary](#summary)
* [Setup](#setup)
* [Example](#example)



## Summary
This project defines an Xcode plugin that leverages the current release of the official [LicensePlist](https://github.com/mono0926/LicensePlist) project.



## Setup

* On the Package Dependecies tab, click on the `+` button to add a dependency.

![plus](https://user-images.githubusercontent.com/4161830/196003313-e48cd0a3-61f1-4f82-8773-5ccf84f7a286.png)

* Enter `https://github.com/alandeguz/LicensePlistPlugin` into the search field, and click on `Add Package`.

![add](https://user-images.githubusercontent.com/4161830/196002989-81aead6c-1a3a-47d8-9a11-424b47bc088c.png)

* Because this a plugin (and *not* code intended for the app), no target will be listed in this dialog. Simply click on `Add Package` here.

![choose](https://user-images.githubusercontent.com/4161830/196003148-ef432db9-eb1d-4c26-a920-0322c5d53464.png)

* Select your Target, then go to `Build Phases`, expand `Run Build Tool Plug-ins`.

![run](https://user-images.githubusercontent.com/4161830/196003575-a6de8f15-9429-4d09-94aa-fbe7af526a33.png)

* Click on the `+` button to bring up the plugin chooser dialog. Click on `LicensePlist` then `Add`.

![select](https://user-images.githubusercontent.com/4161830/196003670-c46e65c0-5065-43cc-aec4-a87b0efcb168.png)

* Copy the [license-plist-config.plist](https://github.com/alandeguz/LicensePlistPlugin/blob/main/license-plist-config.plist) file from this project to root directory of your project, and edit the values for your configuration.



## Example

An example project is available from the [ExampleApp](https://github.com/alandeguz/ExampleApp) repository.

