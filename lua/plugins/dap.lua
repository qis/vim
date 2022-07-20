local canonical = require("canonical")

if vim.g.lsp_cpp then
  local dap = require("dap")
  dap.adapters.lldb = {
    name = "lldb",
    type = "executable",
    command = canonical(vim.fn.exepath(canonical(os.getenv("ACE")) .. "/bin/lldb-vscode"))
  }
end
