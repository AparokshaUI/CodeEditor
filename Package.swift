// swift-tools-version: 5.8
//
//  Package.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import PackageDescription

/// The CodeEditor package.
let package = Package(
    name: "CodeEditor",
    products: [
        .library(
            name: "CodeEditor",
            targets: ["CodeEditor"]
        ),
        .library(
            name: "CCodeEditor",
            targets: ["CCodeEditor"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "CodeEditor",
            dependencies: [.product(name: "Adwaita", package: "Adwaita"), "CCodeEditor"]
        ),
        .systemLibrary(
            name: "CCodeEditor",
            pkgConfig: "gtksourceview-5"
        ),
        .executableTarget(
            name: "Test",
            dependencies: ["CodeEditor", "Adwaita"],
            path: "Tests"
        )
    ]
)
