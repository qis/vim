local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local on_attach = function(client, buffer)
  -- Enable completion triggered by <c-x><c-o>.
  --vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local options = { noremap = true, silent = true, buffer = buffer }
  vim.keymap.set('n', '<Leader>t', vim.lsp.buf.hover, options)
end

--local capabilities = cmp_nvim_lsp.default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.supportsCompletionsRequest = false
capabilities.textDocument.completion = {}

local clangd = (function()
  local path = require("plenary.path")
  local file = vim.fn.exepath((path:new(os.getenv("ACE")) / "bin" / "clangd").filename)
  return vim.loop.fs_stat(file) and file or vim.fn.exepath("clangd")
end)()

if vim.loop.fs_stat(clangd) then
  require("lspconfig").clangd.setup({
    filetypes = { "c", "cpp" },
    single_file_support = false,
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    cmd = {
      clangd,                         -- executable
      "--clang-tidy",                 -- enable clang-tidy diagnostics
      "--background-index",           -- index project code in the background and persist index on disk
      "--completion-style=detailed",  -- granularity of code completion suggestions: bundled, detailed
      "--function-arg-placeholders"   -- completions contain placeholders for method parameters
    },
    on_new_config = function(config, root)
      -- vim.api.nvim_command("cd " .. root)
      local status, cmake = pcall(require, "cmake-tools")
      if status then
        cmake.clangd_on_new_config(config)
      end
    end,
  })
end
