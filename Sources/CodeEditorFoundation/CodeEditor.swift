//
//  CodeEditor.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import CCodeEditor
import Libadwaita

/// GtkSource.View
public class CodeEditor: NativeWidgetPeer {

    /// The source view's code buffer.
    let buffer = CodeBuffer()

    /// Initialize a code editor.
    override public init() {
        super.init()
        nativePtr = codeeditor_init(buffer.nativePtr)
    }

    /// Set the padding between the editor's border and the text.
    /// - Parameters:
    ///     - padding: The value of the padding.
    ///     - edges: The edges that should be affected.
    /// - Returns: The editor
    public func innerPadding(_ padding: Int = 10, _ edges: Set<Edge> = .all) -> Self {
        let padding = Int32(padding)
        for edge in edges {
            switch edge {
            case .top:
                codeeditor_set_top_margin(nativePtr, padding)
            case .bottom:
                codeeditor_set_bottom_margin(nativePtr, padding)
            case .leading:
                codeeditor_set_leading_margin(nativePtr, padding)
            case .trailing:
                codeeditor_set_trailing_margin(nativePtr, padding)
            }
        }
        return self
    }

    /// Set whether the editor shows the line numbers.
    /// - Parameter visible: Whether the line numbers are visible.
    /// - Returns: The editor.
    public func lineNumbers(_ visible: Bool = true) -> Self {
        codeeditor_set_line_numbers(nativePtr, visible ? 1 : 0)
        return self
    }

    /// Get the editor's content text.
    /// - Returns: The text.
    public func getText() -> String {
        buffer.getText()
    }

    /// Set the editor's content text.
    /// - Parameter text: The editor's content.
    public func setText(_ text: String) {
        buffer.setText(text)
    }

    /// Add a handler that gets called when the content text changes.
    /// - Parameter handler: The handler.
    /// - Returns: The editor.
    public func changeHandler(_ handler: @escaping () -> Void) -> Self {
        buffer.changeHandler(handler)
        return self
    }

    /// Set the syntax highlighting programming language.
    /// - Parameter language: The programming language.
    /// - Returns: The editor.
    public func setLanguage(_ language: Language) -> Self {
        buffer.setLanguage(language)
        return self
    }

}
