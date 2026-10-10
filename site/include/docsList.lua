local asteroid = require("asteroid")
local M = {}

local docsList = {
  { url = "getting-started",      name = "Getting started",            folder = 0 },
  { url = "first-steps",          name = "First steps",                folder = 0 },
  { url = "conf-sec",             name = "Configuration and security", folder = 0 },
  { url = "api",                  name = "API reference list",         folder = 0 },
  { url = "api-request",          name = "sm.request",                 folder = 1 },
  { url = "api-header",           name = "sm.header",                  folder = 1 },
  { url = "api-body",             name = "sm.body",                    folder = 1 },
  { url = "api-params",           name = "sm.params",                  folder = 1 },
  { url = "api-form-contents",    name = "sm.form_contents",           folder = 1 },
  { url = "api-set-http-code",    name = "sm.set_http_code",           folder = 2 },
  { url = "api-set-mime-type",    name = "sm.set_mime_type",           folder = 2 },
  { url = "api-set-header",       name = "sm.set_header",              folder = 2 },
  { url = "api-delete-header",    name = "sm.delete_header",           folder = 2 },
  { url = "api-redirect",         name = "sm.redirect",                folder = 2 },
  { url = "api-halt",             name = "sm.halt",                    folder = 2 },
  { url = "api-set-page-content", name = "sm.set_page_content",        folder = 2 },
  { url = "api-escape-html",      name = "sm.escape_html",             folder = 3 },
  { url = "api-unescape-html",    name = "sm.unescape_html",           folder = 3 },
  { url = "api-escape-url",       name = "sm.escape_url",              folder = 3 },
  { url = "api-unescape-url",     name = "sm.unescape_url",            folder = 3 },
  { url = "api-cookies",          name = "sm.cookies",                 folder = 4 },
  { url = "api-set-cookie",       name = "sm.set_cookie",              folder = 4 },
  { url = "api-delete-cookie",    name = "sm.delete_cookie",           folder = 4 },
  { url = "api-version",          name = "sm.VERSION",                 folder = 6 },
  { url = "api-folder",           name = "sm.FOLDER",                  folder = 6 },
}


local folderLists = {
  { id = 0, name = "Introduction" },
  { id = 1, name = "Request APIs" },
  { id = 2, name = "Response APIs" },
  { id = 3, name = "Security APIs" },
  { id = 4, name = "Cookie APIs" },
  { id = 5, name = "Transport APIs" },
  { id = 6, name = "Other APIs" },
  { id = 7, name = "Silvermoon extras" },
}

local folder_template = asteroid.make_template([[
  <button class="big-font doc-btn @open_extra folder-btn-@folder_id!">@icon! @folder_name </button>
  <div class="doc-folder doc-folder-@folder_id @hidden_extra!">
  @content!
  </div>
]])

local link_template = asteroid.make_template([[
  <a class="doc-item big-font @extra!" href="/docs/@url!"> @name!</a>
]])

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
    local contentHTML = ""

    for _, doc in pairs(docsList) do
      if (doc.url == page) then
        extra = 'blue'
      end

      if doc.folder == folder.id then
        contentHTML = contentHTML .. link_template:generate({
          extra = extra,
          url = doc.url,
          name = doc.name
        })
      end

      extra = ""
    end

    local hidden = ""
    local icon = '<i class="bi bi-caret-right-fill" aria-hidden="true"></i>'

    if (folderHasPage) then
      extra = " open"
      icon = '<i class="bi bi-caret-down-fill" aria-hidden="true"></i>'
    else
      hidden = "hidden"
    end

    print(folder_template:generate({
      open_extra = extra,
      folder_id = folder.id,
      icon = icon,
      folder_name = folder.name,
      hidden_extra = hidden,
      content = contentHTML
    }))
  end
end

function M.renderFile(page)
  local lunamark = require("lunamark")

  local file, _, code = io.open(sm.FOLDER .. "/../resources/docs/" .. page .. ".md", "rb")
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
