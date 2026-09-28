# sm.set\_header

`sm.set_header` is a API function which sets current response's header.

## Usage

`sm.set_header(name,content)`

- name - name of a header to set
- content - header's content

Example:

```lua
local auth = sm.header.X_API_TOKEN;
if (auth == "12345") then --100% secure API key check
  sm.set_header("X-Valid-Api-Key","true")
end
```
