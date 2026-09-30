# sm.set_cookie

`sm.set_cookie` is an API function which allows you to modify and create cookies.

## Usage

`sm.set_cookie(name,content,CookieConfig)`

- name - name of the cookie
- content - content of the cookies as a string
- CookiecConfig - cookie configuration dictionary (path, domain, sameSite, secure, httpOnly, partitioned, maxAge, expires, host)

> **NOTE:** set_cookie will change all unset cookie configuration to default! Make sure to save your cookie configuration to easily apply it. 


```lua
local conf = CookieConfig({
  httpOnly = true,
  maxAge = 3600
})

sm.set_cookie("secret", "12345", conf)
```
