local trouble = require("trouble")

vim.diagnostic.config({
  signs = true,
  float = true,
  virtual_text = {
    prefix = "•",
  },
  update_in_insert = false,
  severity_sort = true,
  underline = false,
})

for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { texthl = hl, numhl = hl })
end

trouble.setup()
