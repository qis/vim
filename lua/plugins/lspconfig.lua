local canonical = require("canonical")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

vim.g.lsp_cpp = vim.g.lsp_cpp or false
vim.g.lsp_lua = vim.g.lsp_lua or false
vim.g.lsp_tjs = vim.g.lsp_tjs or false

local status = {}

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.update_capabilities(client_capabilities)

local cpp = {
  exec = canonical(vim.fn.exepath(canonical(os.getenv("ACE")) .. "/bin/clangd")),
  init = function(exec, root)
    require("lspconfig").clangd.setup({
      filetypes = { "c", "cpp" },
      single_file_support = false,
      cmd = {
        exec,                           -- executable
        "--clang-tidy",                 -- enable clang-tidy diagnostics
        "--background-index",           -- index project code in the background and persist index on disk
        "--completion-style=detailed",  -- granularity of code completion suggestions: bundled, detailed
        "--function-arg-placeholders",  -- completions contain placeholders for method parameters
        "--compile-commands-dir=" .. root .. "/build",
      },
      root_dir = function()
        return root .. "/build"
      end,
      capabilities = capabilities,
    })
    status.cpp = root .. " [" .. exec .. "]"
    vim.g.lsp_cpp = true
  end,
  root = nil,
}

local lua = {
  exec = canonical(vim.fn.exepath("lua-language-server")),
  init = function(exec, root, nvim)
    local diagnostics = {}
    local workspace = {}
    local path = {
      "?.lua",
      "?/init.lua",
    }
    if nvim then
      diagnostics = {
        globals = { "vim", "describe" },
        disable = { "lowercase-global" },
      }
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        preloadFileSize = 1000,
        maxPreload = 2000,
      }
      path = vim.split(package.path, ";")
    end
    require("lspconfig").sumneko_lua.setup({
      filetypes = { "lua" },
      single_file_support = false,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = path,
          },
          completion = {
            enable = true,
            callSnippet = "Both",
          },
          diagnostics = diagnostics,
          workspace = workspace,
          telemetry = {
            enable = false,
          },
        },
      },
      root_dir = function()
        return root
      end,
      capabilities = capabilities,
    })
    local info = ""
    if nvim then
      info = " (nvim)"
    end
    status.lua = root .. " [" .. exec .. "]" .. info
    vim.g.lsp_lua = true
  end,
  root = nil,
}

local tjs = {
  exec = canonical(vim.fn.exepath("typescript-language-server")),
  init = function(exec, root)
    require("lspconfig").tsserver.setup({
      filetypes = {
        "javascript",
        "typescript",
      },
      single_file_support = false,
      root_dir = function()
        return root
      end,
      capabilities = capabilities,
    })
    status.tjs = root .. " [" .. exec .. "]"
    vim.g.lsp_tjs = true
  end,
  root = nil,
}

cpp.find = vim.loop.fs_stat(cpp.exec) ~= nil
lua.find = vim.loop.fs_stat(lua.exec) ~= nil
tjs.find = vim.loop.fs_stat(tjs.exec) ~= nil

local cwd = canonical(vim.fn.resolve(vim.loop.cwd()))

if lua.find then
  local nvim = canonical(vim.fn.resolve(vim.api.nvim_call_function("stdpath", { "config" })))
  if cwd:find(nvim, 1, true) == 1 then
    lua.init(lua.exec, nvim, true)
    lua.find = false
    lua.root = cwd
  end
end

local cur = cwd

if cpp.find or lua.find or tjs.find then
  repeat
    if cpp.find then
      if vim.loop.fs_stat(cwd .. "/CMakePresets.json") ~= nil then
        cpp.init(cpp.exec, cwd)
        cpp.find = false
        cpp.root = cwd
      end
    end
    if lua.find then
      if vim.loop.fs_stat(cwd .. "/.luarc.json") ~= nil then
        lua.init(lua.exec, cwd, false)
        lua.find = false
        lua.root = cwd
      end
    end
    if tjs.find then
      if vim.loop.fs_stat(cwd .. "/tsconfig.json") ~= nil then
        tjs.init(tjs.exec, cwd)
        tjs.find = false
        lua.root = cwd
      end
    end
    cur = cwd
    cwd = canonical(vim.fn.resolve(cwd .. "/.."))
  until string.len(cwd) >= string.len(cur) or not (cpp.find or lua.find or tjs.find)
end

if cpp.root ~= nil then
  vim.api.nvim_command("cd " .. cpp.root)
elseif lua.root ~= nil then
  vim.api.nvim_command("cd " .. lua.root)
elseif tjs.root ~= nil then
  vim.api.nvim_command("cd " .. tjs.root)
end

vim.api.nvim_create_user_command("LspReload", function()
  if cpp.root ~= nil then
    cpp.init(cpp.exec, cpp.root)
  end
end, {})

vim.api.nvim_create_user_command("LspStatus", function()
  local report = "LSP Status"
  if status.cpp then
    report = report .. "\nCPP: " .. status.cpp
  end
  if status.lua then
    report = report .. "\nLUA: " .. status.lua
  end
  if status.tjs then
    report = report .. "\nTJS: " .. status.tjs
  end
  print(report)
end, {})
