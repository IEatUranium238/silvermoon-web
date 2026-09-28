# sm.unescape_html

`sm.unescape_html` is an API function used to revert HTML escaping.

## Usage

`sm.unescape_html(content)`

- content - escaped html as string

Example:

```lua
local input = "&lt;b&gt;Hello&lt;/b&gt;"
print(sm.unescape_html(input))
```