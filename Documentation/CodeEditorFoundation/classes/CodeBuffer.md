**CLASS**

# `CodeBuffer`

GtkSource.Buffer

## Properties
### `handlers`

The handlers being called when the content changes.

## Methods
### `init()`

Initialize a code buffer.

### `getText()`

Get the content of the buffer.
- Returns: The content.

### `setText(_:)`

Set the content of the buffer.
- Parameter text: The new content.

### `changeHandler(_:)`

Add a handler that gets called when the content changes.
- Parameter handler: The handler.

### `setLanguage(_:)`

Set the buffer's programming language.
- Parameter language: The programming language.

### `onChange()`

This function gets called when the content changes and updates the handlers.
