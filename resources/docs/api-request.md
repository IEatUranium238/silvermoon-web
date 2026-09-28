# sm.request

`sm.request` is an API that exposes dictionary that contains information about current request such as request type as string.

<br />

Key names use `SCREAMING_SNAKE_CASE` and match ones given by FastCGI.

Example usage:

```lua
if sm.request.REQUEST_METHOD == "GET" then
  print("This is a GET request!")
end
```

For full list of request variables see [this IETF's page](https://datatracker.ietf.org/doc/html/rfc3875#section-4.1)
