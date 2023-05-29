local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local on_attach = function(client, buffer)
  -- Enable completion triggered by <c-x><c-o>.
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local options = { noremap = true, silent = true, buffer = buffer }
  vim.keymap.set('n', '<Leader>t', vim.lsp.buf.hover, options)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

require("lspconfig").clangd.setup({
  filetypes = { "c", "cpp" },
  single_file_support = false,
  capabilities = capabilities,
  on_attach = on_attach,
  handlers = handlers,
  cmd = {
    (function()
      local path = require("plenary.path")
      local file = vim.fn.exepath((path:new(os.getenv("ACE")) / "bin" / "clangd").filename)
      return vim.loop.fs_stat(file) and file or vim.fn.exepath("clangd")
    end)(),                         -- executable
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

-- Deprecated?
-- local client_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = cmp_nvim_lsp.update_capabilities(client_capabilities)
--
-- local path = require("plenary.path")
-- local lua = {
--   exec = vim.fn.exepath("lua-language-server"),
--   init = function(exec, root, nvim)
--     local diagnostics = {}
--     local workspace = {}
--     local paths = {
--       "?.lua",
--       "?/init.lua",
--     }
--
--     if nvim then
--       diagnostics = {
--         globals = { "vim", "describe" },
--         disable = { "lowercase-global" },
--       }
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         preloadFileSize = 1000,
--         maxPreload = 2000,
--       }
--       paths = vim.split(package.path, ";")
--     end
--
--     require("lspconfig").sumneko_lua.setup({
--       filetypes = { "lua" },
--       single_file_support = false,
--       settings = {
--         Lua = {
--           runtime = {
--             version = "LuaJIT",
--             path = paths,
--           },
--           completion = {
--             enable = true,
--             callSnippet = "Both",
--           },
--           diagnostics = diagnostics,
--           workspace = workspace,
--           telemetry = {
--             enable = false,
--           },
--         },
--       },
--       root_dir = function()
--         return tostring(root)
--       end,
--       capabilities = capabilities,
--     })
--     local info = ""
--     if nvim then
--       info = " (nvim)"
--     end
--     status.lua = root .. " [" .. exec .. "]" .. info
--     vim.g.lsp_lua = true
--   end,
--   root = nil,
-- }
--
-- local tjs = {
--   exec = vim.fn.exepath("typescript-language-server"),
--   init = function(exec, root)
--     require("lspconfig").tsserver.setup({
--       filetypes = {
--         "javascript",
--         "typescript",
--       },
--       single_file_support = false,
--       root_dir = function()
--         return root
--       end,
--       capabilities = capabilities,
--     })
--     status.tjs = root .. " [" .. exec .. "]"
--     vim.g.lsp_tjs = true
--   end,
--   root = nil,
-- }
--
-- cpp.find = vim.loop.fs_stat(cpp.exec) ~= nil
-- lua.find = vim.loop.fs_stat(lua.exec) ~= nil
-- tjs.find = vim.loop.fs_stat(tjs.exec) ~= nil
--
-- local cwd = path:new(vim.fn.resolve(vim.loop.cwd()))
--
-- if lua.find then
--   local nvim = vim.fn.resolve(vim.api.nvim_call_function("stdpath", { "config" }))
--   if cwd.filename:find(nvim, 1, true) == 1 then
--     lua.init(lua.exec, nvim, true)
--     lua.root = nvim
--     lua.find = false
--   end
-- end
--
-- local cur = cwd
--
-- if cpp.find or lua.find or tjs.find then
--   repeat
--     if cpp.find then
--       if vim.loop.fs_stat(cwd .. "/CMakePresets.json") ~= nil then
--         cpp.init(cpp.exec, cwd)
--         cpp.root = cwd:absolute()
--         cpp.find = false
--       end
--     end
--     if lua.find then
--       if vim.loop.fs_stat(cwd .. "/.luarc.json") ~= nil then
--         lua.init(lua.exec, cwd, false)
--         lua.root = cwd:absolute()
--         lua.find = false
--       end
--     end
--     if tjs.find then
--       if vim.loop.fs_stat(cwd .. "/tsconfig.json") ~= nil then
--         tjs.init(tjs.exec, cwd)
--         lua.root = cwd:absolute()
--         tjs.find = false
--       end
--     end
--     cur = cwd
--     cwd = cur:parent()
--   until string.len(cwd.filename) >= string.len(cur.filename) or not (cpp.find or lua.find or tjs.find)
-- end
--
-- if cpp.root ~= nil then
-- elseif lua.root ~= nil then
--   vim.api.nvim_command("cd " .. lua.root)
-- elseif tjs.root ~= nil then
--   vim.api.nvim_command("cd " .. tjs.root)
-- end
