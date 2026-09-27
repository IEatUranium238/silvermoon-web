# sm.header

`sm.header` is an API that exposes dictionary that contains current request's HTTP headers.

<br />

Key names use `SCREAMING_SNAKE_CASE`.

Example usage:

```lua
if sm.request.CONTENT_TYPE == "text/html" then
  print("You are sending HTML!")
end
```