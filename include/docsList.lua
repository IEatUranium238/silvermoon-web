local M = {}

local docsList = {
  { url = "getting-started", name = "Getting started", folder = 0 },
  { url = "first-steps",     name = "First steps",     folder = 0 },
  { url = "conf-sec",     name = "Configuration and security",     folder = 0 },
}

local folderLists = {
  { id = 0, name = "Introduction" },
}

local isProd = false

function M.listDocs(page)
  for _, folder in pairs(folderLists) do
    local folderHasPage = false

    for _, doc in pairs(docsList) do
      if doc.folder == folder.id and doc.url == page then
        folderHasPage = true
        break
      end
    end

    local extra = ""
    local icon = '<i class="bi bi-caret-right-fill" aria-hidden="true"></i>'

    if (folderHasPage) then
      extra = " open"
      icon = '<i class="bi bi-caret-down-fill" aria-hidden="true"></i>'
    end

    print('<button class="big-font doc-btn' ..
      extra .. ' folder-btn-' .. folder.id .. '">' .. icon .. " " .. folder.name .. '</button>')

    if (not folderHasPage) then
      extra = "hidden"
    else
      extra = ""
    end

    print('<div class="doc-folder doc-folder-' .. folder.id .. ' ' .. extra .. '">')

    extra = ""

    for _, doc in pairs(docsList) do
      if (doc.url == page) then
        extra = 'blue'
      end

      if doc.folder == folder.id then
        print(
          '<a class="doc-item big-font ' .. extra .. '" href="/docs/' .. doc.url .. '">' .. doc.name .. '</a>'
        )
      end

      extra = ""
    end

    print('</div>')
  end
end

function M.renderFile(page)
  local lunamark = require("lunamark")

  local file, msg, code = io.open(sm.FOLDER .. "/../resources/docs/" .. page .. ".md", "rb")
  local markdown_input = "# Failed to load this documentation page!\n"

  if (file ~= nil) then
    markdown_input = file:read("*all") .. "\n"
    file:close()
  else
    if code == 2 then
      markdown_input = "# Page not found :(\n[Go to main documentation page](/docs/)\n"
    else
      markdown_input = "# Internal server error :(\n[Go to main documentation page](/docs/)\n"
    end
  end

  local writer = lunamark.writer.html.new()
  local parse = lunamark.reader.markdown.new(writer, {
    smart = true,
    definition_lists = true,
    fenced_code_blocks = true,
    header_attributes = true,
    table = true
  })

  local html_output = parse(markdown_input)
  print(html_output)
end

return M;
