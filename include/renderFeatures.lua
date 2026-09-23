local M = {}

function M.render()
  print('<div class=\"side\">')

  local featuresList = {
    "Familiar", "Powered by Lua", "Plug in", "More than web pages"
  }

  local featuresTextList = {
    [[
  No new syntax to learn. Write plain HTML with Lua embedded in &lt;lua&gt; tags. <br />
  If you know HTML and Lua, you already know 90% of Silvermoon.
  ]],
    [[
  Use Lua you already know with extra APIs provided by Silvermoon. <br />
  Meanwhile gaining performance from being powered by LuaJIT.
  ]],
    [[
  Drop into any FastCGI-compatible server. <br />
  Use LuaRocks packages and include external Lua files. <br />
  Silvermoon respects your decisions.
  ]],
    [[
  Web pages, APIs, whatever. <br />
  Silvermoon is flexible enough to power your whole backend.
  ]]
  }

  local featuresCodeList = {
    [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
</head>
<body>
  <h1>Welcome,
    <lua>return sm.cookies.username or "Guest"</lua>!
  </h1>
  <p>Current time: <lua>return os.date("%Y-%m-%d %H:%M:%S")</lua></p>
</body>
</html>]],

    [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My awesome blog</title>
</head>
<body>
  <h1>Recent Posts</h1>
  <lua>
    local posts = {
      {url = "getting-started", title = "Getting started"},
      {url = "advanced-usage", title = "Advanced usage"},
      {url = "tips-and-tricks", title = "Tips & tricks"}
    }

    for _, post in posts do
      print('<a href="/posts/' .. post.url .. '">' 
      .. post.title "</a>)
    end
  </lua>
</body>
</html>]],

    [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User DB list</title>
</head>
<body>
  <ul>
    <lua>
      local sqlite3 = require("lsqlite3")
      local db = sqlite3.open("users.db")

      for row in db:nrows("SELECT id, name, age FROM users") do
        print(string.format("<li>ID: %i <br />Name: %s <br />Age: %i",
        row.id, row.name, row.age))
      end
    </lua>
  </ul>
</body>
</html>]],

    [[
<lua>
  local json = require("cjson")
  local method = sm.request.REQUEST_METHOD

  sm.set_mime_type("application/json")

  if method == "GET" then
    local todos = {
      {id = 1, text = "Learn Silvermoon", completed = true},
      {id = 2, text = "Build an app", completed = false}
    }

    return json.encode(todos)
  else
    sm.set_http_code(400)
    return json.encode({
      success = false,
      message = "Unsupported request type"
    })
  end
</lua>]]
  }

  for index, val in ipairs(featuresList) do
    local extra = "";

    if index ~= 1 then
      extra = 'class="hidden"'
    end

    print([[
    <div id="feature]] .. index .. [[" ]] .. extra .. [[>
      <p class="code">print(features[]] .. index .. [[])</p>
      <h2>]] .. val .. [[</h2>
      <p>
      ]] .. featuresTextList[index] .. [[
      </p>
    </div>
    ]]
    )
  end

  print([[
    <div class="control-btns">
      <button aria-label="See previous feature" class="big-font hidden" id="featureBack">
        <i class="bi bi-arrow-left" aria-hidden="true"></i> Back
      </button>
      <button aria-label="See next feature" class="big-font" id="featureFord">
        Next <i class="bi bi-arrow-right" aria-hidden="true"></i>
      </button>
    </div>
  ]])
  print("</div>")

  for index, val in ipairs(featuresCodeList) do
    local extra = "";

    if index ~= 1 then
      extra = 'class="hidden"'
    end

    print([[
    <pre aria-hidden="true" id="code]] .. index .. [[" ]] .. extra .. [[><code class="language-html">]] .. sm.escape_html(val) .. [[</code></pre>
    ]]
    )
  end
end

return M
