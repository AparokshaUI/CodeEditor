//
//  CodeEditor.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import Adwaita
import CCodeEditor

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
        let buffer = ViewStorage(gtk_source_buffer_new(nil)?.opaque())
        let editor = ViewStorage(
            gtk_source_view_new_with_buffer(buffer.pointer?.cast())?.opaque(),
            content: ["buffer": [buffer]]
        )
        codeeditor_buffer_set_theme_adaptive(buffer.pointer?.cast())
        update(editor, modifiers: modifiers, updateProperties: true)
        return editor
    }

    /// Update a view storage to the editor.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        if let buffer = storage.content["buffer"]?.first {
            buffer.connectSignal(name: "changed") {
                let text = getText(buffer: buffer)
                if self.text != text {
                    self.text = text
                }
            }
            if updateProperties {
                if getText(buffer: buffer) != self.text {
                    gtk_text_buffer_set_text(buffer.pointer?.cast(), text, -1)
                }
                setLanguage(buffer: buffer)
            }
        }
        if updateProperties {
            if paddingEdges.contains(.top) {
                gtk_text_view_set_top_margin(storage.pointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.bottom) {
                gtk_text_view_set_bottom_margin(storage.pointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.leading) {
                gtk_text_view_set_left_margin(storage.pointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.trailing) {
                gtk_text_view_set_right_margin(storage.pointer?.cast(), padding.cInt)
            }
            gtk_source_view_set_show_line_numbers(storage.pointer?.cast(), numbers.cBool)
        }
    }

    /// Get the text view's content.
    /// - Parameter buffer: The text view's buffer.
    /// - Returns: The content.
    func getText(buffer: ViewStorage) -> String {
        let startIter: UnsafeMutablePointer<GtkTextIter> = .allocate(capacity: 1)
        let endIter: UnsafeMutablePointer<GtkTextIter> = .allocate(capacity: 1)
        gtk_text_buffer_get_start_iter(buffer.pointer?.cast(), startIter)
        gtk_text_buffer_get_end_iter(buffer.pointer?.cast(), endIter)
        return .init(
            cString: gtk_text_buffer_get_text(buffer.pointer?.cast(), startIter, endIter, true.cBool)
        )
    }

    /// Get the text view's programming language.
    /// - Parameter buffer: The text view's buffer.
    func setLanguage(buffer: ViewStorage) {
        let manager = gtk_source_language_manager_get_default()
        let language = gtk_source_language_manager_get_language(manager, language.languageName)
        gtk_source_buffer_set_language(buffer.pointer?.cast(), language)
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
