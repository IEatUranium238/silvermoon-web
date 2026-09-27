# First steps

Now, as you set up your Silvermoon to run and connected it to the web server, it's time to write our first web page!

## Hello, world!

let's create a file in our web server's web root directory called `index.sm`:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hello, world!</title>
  </head>
  <body>
    <h1>Hello, <lua>return "<b>world!</b>"</lua></h1>
  </body>
</html>
```

If everything is set up as should, you should see a header tag with "Hello, world!" in it.

Silvermoon executes the code inside the `<lua>` tags

## Returned HTML content

Did you also notice that "world!" part is bold? This is because silvermoon renders HTML content lua prints or return.

To prevent that you simply can escape it with [sm.escape_html()](/docs/api-escape-html) API:

```lua
return sm.escape_html("<b>world!</b>")
```

Now it will be "Hello, \<b>world\</b>" with world not being bold anymore.

This API is also very helpfull for taking in untrusted input that you plan to render.

Example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Website</title>
</head>
<body>
  <lua>
    local evil = '<script>alert("HAHAHAH! I have full control here! Wait why it\'s not working...")</script>'
    return sm.escape_html(evil)
  </lua>
</body>
</html>
```

Will just output following as plain text: 

<br />

\<script>alert("HAHAHAH! I have full control here! Wait why it's not working...")\</script>

<br />

Without actually executing the script.

<br />

We can also use this feature to render data as ready to use HTML.
Example:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Todo list</title>
  </head>
  <body>
    <h1>TODO list</h1>
    <ul>
      <lua>
        local tasks = {
          { name = "Water the plants", done = true },
          { name = "Feed the cat", done = true },
          { name = "Buy ink catridges", done = false },
        }

        for _, task in pairs(tasks) do
          local status = "not done!" -- default status

          if (task.done) then
            status = "done!"
          end

          print("<li>" .. task.name .. " - " 
            .. "<b>" .. status .. "</b>" .. "</li>");
        end
      </lua>
    </ul>
  </body>
</html>
```

## Return vs print

Silvermoon allows you to return html in 2 ways:

1. The print() function: <br />
   Recommended way for longer scripts <br />
   Can be used multiple times

2. The return keyword: <br />
   Recommended for single line scripts <br />
   Can be used only once, at the end of the script.

Examples inside the `<lua>` tag:

```lua
return "Hi!";
x = 5 + 5; -- Error, lua expected end of script.
```

```lua
print("Hi!");
x = 5 + 5; -- Works fine
```

## Lua inside .sm

Silvermoon embeds a Lua 5.1 runtime via LuaJIT.

<br />

Also you might have noticed that we put `local` in start of value names for reason.
This is because it makes this value scoped to this tag.

Example:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lua test</title>
  </head>
  <body>
    <ul>
      <lua>
        global_val = "I can be seen by anyone below me!"
        local local_val = "I can be seen only by this tag!"
      </lua>

      <lua>
        print(global_val) -- I can be seen by anyone below me!
        print("<br />")
        print(local_val) -- nil
      </lua>
    </ul>
  </body>
</html>
```

## Other Lua files

Sometimes writing all of the code inside the `<lua>` tag near the markup can feel messy.
Or you just want to add your already existing lua files.

<br />

You can use `require()` to import stuff from your lua modules.
These modules act exactly same as how would code inside `lua` tag, they also get all of Silvermoon's APIs.

<br />

Example:

`render.lua`
```lua
local M = {}

local tasks = {
  { name = "Water the plants", done = true },
  { name = "Feed the cat", done = true },
  { name = "Buy ink catridges", done = false },
}

function M.get_tasks()
  for _, task in pairs(tasks) do
    local status = "not done!"

    if (task.done) then
      status = "done!"
    end

    print("<li>" .. task.name .. " - " 
      .. "<b>" .. status .. "</b>" .. "</li>");
  end
end

return M
```

`index.sm`
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Todo list</title>
  </head>
  <body>
    <h1>TODO list</h1>
    <ul>
      <lua>
        local render = require("render");
        render.get_tasks();
      </lua>
    </ul>
  </body>
</html>
```

> **NOTE:** If you put your lua file directory above .sm file's folder, you need to modify module path variable.

> <br />

> To modify do following:

> ```lua
> package.path = package.path .. ";/full/path/to/module/folder/?.lua"; 
> local module = require("mymodule");
> ```

# LuaRocks packages

We all know that you can't do most of things by yourself, so you need libraries.

<br />

[LuaRocks](https://luarocks.org) is a community run package manager for Lua. Silvermoon supports it out of the box.

> **NOTE:** Silvermoon does not contain LuaRocks! You need to install it by yourself.

Let's install a library for json and networking! We are going to choose cjson & luasec (for https) for this segment.

```bash
luarocks install lua-cjson
luarocks install luasec
```

> **NOTE:** you need OpenSSL to be installed to work, else luasec will fail to install.

> **NOTE:** you might need to run it with sudo if you install a package system-wide!

Now, let's use our installed packages, let's send a request to [cataas](https://cataas.com)'s API and display a cat photo along side it's data.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cat picture</title>
  <style>
    img {
      width: auto;
      max-height: 500px;
    }

    body {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;

      height: 100vh;
    }
  </style>
</head>
<body>
  <lua>
    local http = require("ssl.https")
    local cjson = require("cjson")
    local ltn12 = require("ltn12")

    local response_table = {}

    local result, status_code = http.request {
      url = "https://cataas.com/cat?json=true",
      method = "GET",
      sink = ltn12.sink.table(response_table)
    }

    -- Check status
    if status_code ~= 200 then
      print("Failed to load a cat!")
      do return end -- Stop tag's script execution
    end

    --Put pars together and parse JSON
    local response = table.concat(response_table)
    local cat_data = cjson.decode(response)

    -- Print the photo
    print('<img src="https://cataas.com/cat/' .. cat_data["id"] .. '" />')

    -- Print the ID
    print('<p> Cat\'s ID: ' .. cat_data["id"] .. '</p>')

    -- Print the tags
    print("<p> Cat's tags: </p>")
    print("<ul>")

    for _,tag in pairs(cat_data["tags"]) do
      print("<li>" .. tag .. "</li>");
    end

    print("</ul>")
  </lua>
</body>
</html>
```

If everything works as intended you should see:

- A cat picture
- It's ID
- And tags if any

## What's next?

- [Your first project: tic-tac-toe](/docs/tic-tac-toe)
- [Lua API referance](/docs/api)
