# sm.delete_cookie

`sm.delete_cookie` is an API function which deletes a cookie. Under the hood it sets cookie's expires to start of UNIX time making it delete itself.

## Usage

`sm.delete_cookie(name)`

- name - name of a cookie to delete

```lua
sm.delete("myCookie")
```