# API reference list

This page acts as a list of all Silvermoon's APIs sorted by categories.

<br />

Click onto API's name to get redirected to detailed page about it!

## Request

- [`sm.request`](/docs/api-request) - request information
- [`sm.header`](/docs/api-header) - http headers
- [`sm.body`](/docs/api-body) - request body
- [`sm.params`](/docs/api-params) - url params
- [`sm.form_contents`](/docs/api-form-contents) - form's submited content

## Response

- [`sm.set_http_code()`](/docs/api-set-http-code) - Set response http status code
- [`sm.set_mime_type()`](/docs/api-set-mime-type) - Set response mime type
- [`sm.set_header()`](/docs/api-set-header) - Set a header
- [`sm.delete_header()`](/docs/api-delete-header) - Delete a header
- [`sm.redirect()`](/docs/api-redirect) - Redirect to a page
- [`sm.halt()`](/docs/api-halt) - Halt rendering of the page
- [`sm.set_page_content()`](/docs/api-set-page-content) - Set page's contents and halt rendering

## Security

- [`sm.escape_html()`](/docs/api-escape-html) - Escape HTML for safe rendering
- [`sm.unescape_html()`](/docs/api-unescape-html) - Revert HTML escaping
- [`sm.escape_url()`](/docs/api-escape-url) - Escape URL for transport
- [`sm.unescape_url()`](/docs/api-unescape-url) - Revert URL escaping

## Cookies

- [`sm.cookies`](/docs/api-cookies) - cookies
- [`sm.set_cookie`](/docs/api-set-cookie) - set cookie
- [`sm.delete_cookie`](/docs/api-delete-cookie) - remove cookie

## Other

- [`sm.VERSION`](/docs/api-version) - silvermoon's version
- [`sm.FOLDER`](/docs/api-folder) - current .sm file's parent folder
