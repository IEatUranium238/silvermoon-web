local M = {}

local docsList = {
  { url = "getting-started", name = "Getting started", fp = "gettingStarted.md", folder = 0 }
}

local folderLists = {
  { id = 0, name = "Introduction" }
}

function M.listDocs()
  for _, v in pairs(docsList) do
    print('<a class="doc-item big-font" href="/docs/' .. v.url .. '">' .. v.name .. '</a>')
  end
end

function M.renderFile()
  local lunamark = require("lunamark")
  local http = require("socket.http")

  local writer = lunamark.writer.html.new()
  local parse = lunamark.reader.markdown.new(writer, {
    smart = true,
    definition_lists = true,
    fenced_code_blocks = true,
    header_attributes = true,
    table = true
  })

  local markdown_input = "# Failed to load documentation!\n"


  --TODO: change to https in production
  local body, code = http.request("http://" .. sm.header.HOST .. "/resources/docs/gettingStarted.md")

  if code == 200 then
    markdown_input = body .. "\n";
  end

  local html_output = parse(markdown_input)
  print(html_output)
end

return M;
