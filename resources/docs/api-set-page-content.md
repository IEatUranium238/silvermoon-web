# sm.set\_page\_content

`sm.set_page_content` is an API function that replaces current page contents and stops rendering.

## Usage

`sm.set_page_content(content)` 

- content - new page content as string

> **NOTE:** `sm.set_page_content` doesn't stop lua tag execution use `do return end` to stop lua execution!

Example:

```lua
sm.set_page_content("Hello there!")
do return end
```