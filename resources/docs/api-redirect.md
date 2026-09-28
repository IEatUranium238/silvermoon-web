# sm.redirect

`sm.redirect` is an API function which allows to tell browser to redirect user somewhere

## Usage

`sm.redirect(page)`

- page - url to redirect to

> **NOTE:** redirect does ***NOT*** stop execution of tag's script or rendering of the page.
> Use [sm.halt()](/docs/api-halt) to stop page rendering and `do return end` to stop tag's script execution.

Example:

```lua
if (user.loged_in == false) then
  sm.redirect("/login")
  sm.halt()
  do return end
end
```