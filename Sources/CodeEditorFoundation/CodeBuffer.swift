//
//  CodeBuffer.swift
//  CodeEditor
//
//  Created by david-swift on 27.11.23.
//

import CCodeEditor
import Libadwaita

/// GtkSource.Buffer
class CodeBuffer: NativeWidgetPeer {

    /// The handlers being called when the content changes.
    var handlers: [() -> Void] = []

    /// Initialize a code buffer.
    override init() {
        super.init()
        nativePtr = codeeditor_init_buffer()
        let selfAddr = unsafeBitCast(self, to: UInt64.self)
        codeeditor_buffer_init_signals(nativePtr, selfAddr)
        codeeditor_buffer_set_theme_adaptive(nativePtr)
    }

    /// Get the content of the buffer.
    /// - Returns: The content.
    func getText() -> String {
        .init(cString: codeeditor_buffer_get_text(nativePtr))
    }

    /// Set the content of the buffer.
    /// - Parameter text: The new content.
    func setText(_ text: String) {
        codeeditor_buffer_set_text(nativePtr, text)
    }

    /// Add a handler that gets called when the content changes.
    /// - Parameter handler: The handler.
    func changeHandler(_ handler: @escaping () -> Void) {
        handlers.append(handler)
    }

    /// Set the buffer's programming language.
    /// - Parameter language: The programming language.
    func setLanguage(_ language: Language) {
        codeeditor_buffer_set_language(nativePtr, language.languageName)
    }

    /// This function gets called when the content changes and updates the handlers.
    func onChange() {
        for handler in handlers {
            handler()
        }
    }

}

/// This function gets called when the content changes.
/// - Parameters:
///     - ptr: The pointer.
///     - userData: Data about the buffer.
@_cdecl("buffer_on_change_cb")
func buffer_on_change_cb(
    ptr: UnsafeMutableRawPointer,
    userData: UnsafeMutableRawPointer
) {
    let editor = Unmanaged<CodeBuffer>.fromOpaque(userData).takeUnretainedValue()
    editor.onChange()
}
