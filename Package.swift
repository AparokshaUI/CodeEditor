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
            name: "CodeEditorFoundation",
            targets: ["CodeEditorFoundation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.1.4"),
        .package(url: "https://github.com/AparokshaUI/Libadwaita", from: "0.1.1")
    ],
    targets: [
        .target(
            name: "CodeEditor",
            dependencies: ["CodeEditorFoundation", .product(name: "Adwaita", package: "Adwaita")]
        ),
        .target(
            name: "CodeEditorFoundation",
            dependencies: ["CCodeEditor", .product(name: "Libadwaita", package: "Libadwaita")]
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
