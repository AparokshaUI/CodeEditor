**STRUCT**

# `CodeEditor`

A text or code editor widget.

## Properties
### `text`

The editor's content.

### `padding`

The padding between the border and the content.

### `paddingEdges`

The edges affected by the padding.

### `numbers`

Whether the line numbers are visible.

### `language`

The programming language for syntax highlighting.

## Methods
### `init(text:)`

Initialize a code editor.
- Parameter text: The editor's content.

### `container(modifiers:)`

Get the editor's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:)`

Update a view storage to the editor.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.

### `innerPadding(_:edges:)`

Add padding between the editor's content and border.
- Parameters:
    - padding: The padding's value.
    - edges: The affected edges.
- Returns: The editor.

### `lineNumbers(_:)`

Set the visibility of line numbers.
- Parameter visible: Whether the numbers are visible.
- Returns: The editor.

### `language(_:)`

Set the syntax highlighting programming language.
- Parameter language: The programming language.
- Returns: The editor.
