# ignite_dev_tools

A Flutter application that monitors and parses log files to render UI component trees.

## Features

  - Watches log files (e.g. `debug_two.log`) for UI component definitions
  - Parses component definitions into a structured tree format
  - Renders the component tree in the application UI

## Example Log Format

```
3CounterComponent {
  key: "test-counter-1"
  offset: { x: 0, y: 0 }
  size: { w:200, h: 200 }
  tappable: true
  children: [
    13TextComponent {
      key: "text-count"
      offset: { x: 50, y: 80 }
      size: { w:100, h: 30 }
      tappable: false
      text: "Count: 1"
      style: TextStyle { color: Color {r:0, g:0, b:0, a:255}, fontSize: 20, weight: Bold }
    }
  ]
}
```
-----

### Abstract Syntax Tree (AST)

The log parser first tokenizes the input string and then builds an **Abstract Syntax Tree (AST)**. The AST provides a structured, hierarchical representation of the UI component data, making it easier to render the UI tree.

Here is the AST generated from the log file example above:


```
ObjectNode {
  key: StringNode { "test-counter-1" },
  offset: ObjectNode {
    x: NumberNode { 0 },
    y: NumberNode { 0 }
  },
  size: ObjectNode {
    w: NumberNode { 200 },
    h: NumberNode { 200 }
  },
  tappable: BooleanNode { true },
  children: ArrayNode {
    [
      ObjectNode {
        key: StringNode { "text-count" },
        offset: ObjectNode {
          x: NumberNode { 50 },
          y: NumberNode { 80 }
        },
        size: ObjectNode {
          w: NumberNode { 100 },
          h: NumberNode { 30 }
        },
        tappable: BooleanNode { false },
        text: StringNode { "Count: 1" },
        style: ObjectNode {
          color: ObjectNode {
            r: NumberNode { 0 },
            g: NumberNode { 0 },
            b: NumberNode { 0 },
            a: NumberNode { 255 }
          },
          fontSize: NumberNode { 20 },
          weight: StringNode { "Bold" }
        }
      }
    ]
  }
}
```
