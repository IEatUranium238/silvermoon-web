# sm.params

`sm.params` is an API that exposes dictionary that contains current url params as unescaped url strings.

<br />

Example usage:

```lua
print("Welcome " .. (sm.params.name or "Guest"))
```