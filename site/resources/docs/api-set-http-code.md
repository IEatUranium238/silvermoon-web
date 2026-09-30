# sm.set\_http\_code

`sm.set_http_code` is a API function which sets current response's http response code.

## Usage

`sm.set_http_code(code)`

- code - a http code number (ex. 400,500,404)

Example:

```lua
local auth = sm.headers.X_API_TOKEN;
if (auth == nil) then
  sm.set_http_code(403)
end
```
