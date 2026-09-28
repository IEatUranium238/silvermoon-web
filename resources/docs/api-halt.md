# sm.halt

`sm.halt` is an API function used to stop rendering of the page's contents.

## Usage

> **NOTE:** sm.halt does not stop code execution in current lua tag. Use `do return end` to finish code execution in the tag.

```lua
sm.halt()
do return end

print("I won't be executed!")
```