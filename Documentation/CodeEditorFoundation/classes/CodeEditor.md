**CLASS**

# `CodeEditor`

GtkSource.View

## Properties
### `buffer`

The source view's code buffer.

## Methods
### `init()`

Initialize a code editor.

### `innerPadding(_:_:)`

Set the padding between the editor's border and the text.
- Parameters:
    - padding: The value of the padding.
    - edges: The edges that should be affected.
- Returns: The editor

### `lineNumbers(_:)`

Set whether the editor shows the line numbers.
- Parameter visible: Whether the line numbers are visible.
- Returns: The editor.

### `getText()`

Get the editor's content text.
- Returns: The text.

### `setText(_:)`

Set the editor's content text.
- Parameter text: The editor's content.

### `changeHandler(_:)`

Add a handler that gets called when the content text changes.
- Parameter handler: The handler.
- Returns: The editor.

### `setLanguage(_:)`

Set the syntax highlighting programming language.
- Parameter language: The programming language.
- Returns: The editor.
