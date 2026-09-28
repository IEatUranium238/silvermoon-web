# sm.escape_html

`sm.escape_html` is an API function used to escape HTML to make it safe to print.

## Usage

`sm.escape_html(content)`

- content - html as string

Example:

```lua
local input = "<b>Hello</b>"
print(sm.escape_html(input))
```