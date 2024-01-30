//
//  main.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import Adwaita
import CodeEditor

// swiftlint:disable missing_docs implicitly_unwrapped_optional no_magic_numbers

@main
struct Test: App {

    let id = "io.foo.Bar"
    @State private var text = ""
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "main") { window in
            ScrollView {
                CodeEditor(text: $text)
                    .innerPadding()
                    .lineNumbers()
                    .language(.swift)
            }
            .topToolbar {
                HeaderBar.start {
                    Button("Print", icon: .default(icon: .printer)) {
                        print(text)
                    }
                    .keyboardShortcut("Return".ctrl(), app: app)
                    .style("suggested-action")
                }
            }
            .onAppear {
                window.setDefaultSize(width: 300, height: 250)
            }
        }
        .closeShortcut()
        .quitShortcut()
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
