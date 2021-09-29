// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModuleBase",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ModuleBase",
            targets: ["ModuleBase"]),
        .library(
          name: "Base",
          targets: ["Base"]),
        .library(
          name: "CommonFeatures",
          targets: ["CommonFeatures"]),
        .library(
          name: "TestModule",
          targets: ["TestModule"]),
        .library(
          name: "TestModuleInterface",
          targets: ["TestModuleInterface"]),
        .library(
          name: "TestDependantModule",
          targets: ["TestDependantModule"]),
        .library(
          name: "TestDependantModuleInterface",
          targets: ["TestDependantModuleInterface"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
      .target(
        name: "Base",
        dependencies: []),
        .target(
            name: "ModuleBase",
            dependencies: ["Base"]),
      .target(name: "CommonFeatures", dependencies: ["ModuleBase"]),
        .target(
          name: "TestModuleInterface",
          dependencies: ["ModuleBase", "CommonFeatures"]),
        .target(
          name: "TestModule",
          dependencies: ["TestModuleInterface"]),
      .target(
        name: "TestDependantModuleInterface",
        dependencies: ["ModuleBase"]),
      .target(
        name: "TestDependantModule",
        dependencies: ["TestDependantModuleInterface", "TestModuleInterface"]),
        .testTarget(
            name: "Tests",
            dependencies: ["ModuleBase", "TestModule", "TestDependantModule"]),
      
    ]
)
