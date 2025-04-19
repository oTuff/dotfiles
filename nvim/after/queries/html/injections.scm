vim.treesitter.query.set("html", "injections", [[
(script_element
  (raw_text) @injection.content
  (#set! injection.language "javascript"))
]])
