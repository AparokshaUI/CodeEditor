//
//  CodeEditor.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import Adwaita
import CodeEditorFoundation
import Libadwaita

/// A text or code editor widget.
public struct CodeEditor: Widget {

    /// The editor's content.
    @Binding var text: String
    /// The padding between the border and the content.
    var padding = 0
    /// The edges affected by the padding.
    var paddingEdges: Set<Edge> = []
    /// Whether the line numbers are visible.
    var numbers = false
    /// The programming language for syntax highlighting.
    var language: Language = .plain

    /// Initialize a code editor.
    /// - Parameter text: The editor's content.
    public init(text: Binding<String>) {
        self._text = text
    }

    /// Get the editor's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let editor = CodeEditorFoundation.CodeEditor()
        _ = editor.changeHandler {
            self.text = editor.getText()
        }
        editor.setText(text)
        _ = editor
            .innerPadding(padding, paddingEdges)
            .lineNumbers(numbers)
            .setLanguage(language)
        return .init(editor)
    }

    /// Update a view storage to the editor.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let editor = storage.view as? CodeEditorFoundation.CodeEditor, editor.getText() != text {
            editor.setText(text)
            _ = editor
                .innerPadding(padding, paddingEdges)
                .lineNumbers(numbers)
                .setLanguage(language)
        }
    }

    /// Add padding between the editor's content and border.
    /// - Parameters:
    ///     - padding: The padding's value.
    ///     - edges: The affected edges.
    /// - Returns: The editor.
    public func innerPadding(_ padding: Int = 10, edges: Set<Edge> = .all) -> Self {
        var newSelf = self
        newSelf.padding = padding
        newSelf.paddingEdges = edges
        return newSelf
    }

    /// Set the visibility of line numbers.
    /// - Parameter visible: Whether the numbers are visible.
    /// - Returns: The editor.
    public func lineNumbers(_ visible: Bool = true) -> Self {
        var newSelf = self
        newSelf.numbers = visible
        return newSelf
    }

    /// Set the syntax highlighting programming language.
    /// - Parameter language: The programming language.
    /// - Returns: The editor.
    public func language(_ language: Language) -> Self {
        var newSelf = self
        newSelf.language = language
        return newSelf
    }

}
