# sm.form_contents

`sm.form_contents` is an API that exposes dictionary that contains form's data if provided.

<br />

Example usage:

```lua
if (sm.form_contents.password == "12345") then
  print("Right password")
else
  print("Wrong password")
end
```