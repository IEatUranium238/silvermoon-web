# sm.unescape_url

`sm.unescape_url` is an API function used to revert URL escaping

## Usage

`sm.unescape_url(content)`

- content - content to unescape as string

Example:

```lua
local data = "my%3Bcomplex%3Bdata%3Bstructure"
print(sm.unescape_url())
```