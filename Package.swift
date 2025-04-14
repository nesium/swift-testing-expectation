// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-testing-expectation",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6),
		.macCatalyst(.v13),
		.visionOS(.v1),
	],
	products: [
		.library(
			name: "TestingExpectation",
			targets: ["TestingExpectation"]
		),
	],
	targets: [
		.target(
			name: "TestingExpectation",
			dependencies: [],
			swiftSettings: [
				.swiftLanguageMode(.v6),
			]
		),
		.testTarget(
			name: "TestingExpectationTests",
			dependencies: ["TestingExpectation"],
			swiftSettings: [
				.swiftLanguageMode(.v6),
			]
		),
	]
)
