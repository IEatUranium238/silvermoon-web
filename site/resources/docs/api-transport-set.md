# sm.transport.set

`sm.transport.set` is an API function that allows you to set a key in transport state.

Transport state can be used to save data between requests and pages. Usefull for caching and compute heavy values that you need to calculate once.

> **NOTE:** Transport state is visible to all request, don't use it to store sensetive information.
> Transport gets cleared on Silvermoon FastCGI server restart, don't use it like a database.

## Usage

`sm.transport.set(key,value)`

- key - name of a key to set
- value - value to set key to

Example:

```lua
sm.transport.set("my-key","Hello, world")
```