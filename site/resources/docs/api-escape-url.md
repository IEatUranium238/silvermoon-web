# sm.escape_url

`sm.escape_url` is an API function used to escape URL to make it safe to transport

## Usage

`sm.escape_url(content)`

- content - content to escape as string

Example:

```lua
local input = "my;complex;data;structure"
local link = "https://my.website.cool/?data=" .. sm.escape_url(input)
```