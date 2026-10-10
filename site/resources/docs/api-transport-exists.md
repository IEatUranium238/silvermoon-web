# sm.transport.exists

`sm.transport.exists` is an API function that allows you to check existance of a key in transport state.

Transport state can be used to save data between requests and pages. Usefull for caching and compute heavy values that you need to calculate once.

> **NOTE:** Transport state is visible to all request, don't use it to store sensetive information.
> Transport gets cleared on Silvermoon FastCGI server restart, don't use it like a database.

## Usage

`sm.transport.exists(key)`

- key - name of a key to check existance of

Example:

```lua
print(sm.transport.exists("my-key"))
```