// swift-tools-version:5.2
import PackageDescription
let packageName = "demoApp" // <-- Change this to yours
let package = Package(
  name: "demoApp",
  // platforms: [.iOS("9.0")],
  products: [
    .library(name: packageName, targets: [packageName])
  ],
  targets: [
    .target(
      name: packageName,
      path: packageName
    )
  ]
)