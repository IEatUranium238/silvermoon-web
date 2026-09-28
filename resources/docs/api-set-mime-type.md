# sm.set\_mime\_type

`sm.set_mite_type` is a API function which sets current response's mime type code.

## Usage

`sm.set_mime_type(type)`

- type - a mime type string (ex. "text/plain"), for full list [see this IANA page](https://www.iana.org/assignments/media-types)

Example:

```lua
sm.set_mime_type("text/plain")
print("This is plain text!")
```
