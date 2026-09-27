# sm.body

`sm.body` is an API that exposes request body as a string.

<br />

Example usage:

```lua
local cjson = require("cjson")
print(cjson.decode(sm.body))
```