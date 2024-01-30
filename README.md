<p align="center">
  <img width="256" alt="CodeEditor Icon" src="Icons/CodeEditorIcon.png">
  <h1 align="center">CodeEditor</h1>
</p>

<p align="center">
  <a href="https://github.com/AparokshaUI/CodeEditor">
  GitHub
  </a>
  ·
  <a href="Documentation/CodeEditor/README.md">
  CodeEditor Docs
  </a>
  ·
  <a href="Documentation/CodeEditorFoundation/README.md">
  CodeEditorFoundation Docs
  </a>
</p>

_CodeEditor_ adds support for text and code editors to GNOME apps built using [Adwaita for Swift](https://github.com/AparokshaUI/Adwaita).

## Table of Contents

- [Installation](#Installation)
- [Usage](#Usage)
- [Thanks](#Thanks)

## Installation
### Dependencies
Install `gtksourceview-devel` or similar (based on the package manager) as well as `gtk4-devel` and `libadwaita-devel` (or similar).

### Swift Package
1. Open your Swift package in GNOME Builder, or any other IDE.
2. Open the `Package.swift` file.
3. Into the `Package` initializer, under `dependencies`, paste:
```swift
.package(url: "https://github.com/AparokshaUI/CodeEditor", from: "0.1.0")   
```

## Usage

Take a look at the simple [sample app](Tests/main.swift).
Check out the [Adwaita](https://github.com/AparokshaUI/Adwaita) packages.

## Thanks

### Dependencies
- [Adwaita](https://github.com/AparokshaUI/Adwaita) licensed under the [GPL-3.0 license](https://github.com/AparokshaUI/Adwaita/blob/main/LICENSE.md)

### Other Thanks
- The [contributors](Contributors.md)
- [SwiftLint](https://github.com/realm/SwiftLint) for checking whether code style conventions are violated
- The programming language [Swift](https://github.com/apple/swift)
- [SourceDocs](https://github.com/SourceDocs/SourceDocs) used for generating the [docs](Documentation/Reference/README.md)
- [GtkSourceView](https://gitlab.gnome.org/GNOME/gtksourceview/) for the widgets
