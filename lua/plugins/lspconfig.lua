local status = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.update_capabilities(client_capabilities)

local function canonical(path)
  if path == nil then
    return ""
  end
  return string.gsub(path, '[\\]', { ['\\'] = '/' })
end

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
    table.insert(status, "CPP: " .. root .. " [" .. exec .. "]")
  end
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
    table.insert(status, "LUA: " .. root .. " [" .. exec .. "]" .. info)
  end
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
    table.insert(status, "TJS: " .. root .. " [" .. exec .. "]")
  end
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
  end
end

local cur = cwd
local root = {}

if cpp.find or lua.find or tjs.find then
  --local log = assert(vim.loop.fs_open("lspconfig.log", "a", tonumber('644', 8)))
  repeat
    --vim.loop.fs_write(log, cwd .. "\n", -1, nil)
    if cpp.find then
      if vim.loop.fs_stat(cwd .. "/build/compile_commands.json") ~= nil then
        table.insert(root, cwd)
        cpp.init(cpp.exec, cwd)
        cpp.find = false
      end
    end
    if lua.find then
      if vim.loop.fs_stat(cwd .. "/.luarc.json") ~= nil then
        table.insert(root, cwd)
        lua.init(lua.exec, cwd, false)
        lua.find = false
      end
    end
    if tjs.find then
      if vim.loop.fs_stat(cwd .. "/tsconfig.json") ~= nil then
        table.insert(root, cwd)
        tjs.init(tjs.exec, cwd)
        tjs.find = false
      end
    end
    cur = cwd
    cwd = canonical(vim.fn.resolve(cwd .. "/.."))
  until string.len(cwd) >= string.len(cur) or not (cpp.find or lua.find or tjs.find)
end

local cd = nil
for _, path in ipairs(root) do
  if cd == nil or string.len(cd) > string.len(path) then
    cd = path
  end
end
if cd ~= nil then
  vim.api.nvim_command("cd " .. cd)
end

vim.api.nvim_create_user_command("LspStatus", function()
  local report = ""
  for _, s in ipairs(status) do
    report = report .. "\n" .. s
  end
  print("LSP Status" .. report)
end, {})
