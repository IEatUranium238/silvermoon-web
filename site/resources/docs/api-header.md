# sm.header

`sm.header` is an API that exposes dictionary that contains current request's HTTP headers contents as string.

These are FastCGI values that start with `HTTP_`, with that part removed.

<br />

Key names use `SCREAMING_SNAKE_CASE`.

Example usage:

```lua
if string.find(sm.header.USER_AGENT, "Windows") then
  print("You are using windows!")
end
```