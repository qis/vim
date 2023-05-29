local dap = require("dap")

dap.defaults.fallback.stopOnEntry = false
dap.defaults.fallback.environment = {}

dap.adapters.lldb = {
  name = "lldb",
  type = "executable",
  command = (function()
    local path = require("plenary.path")
    local file = vim.fn.exepath((path:new(os.getenv("ACE")) / "bin" / "lldb-vscode").filename)
    return vim.loop.fs_stat(file) and file or vim.fn.exepath("lldb-vscode")
  end)(),
  enrich_config = function(config, on_config)
    on_config(config)
    require("dapui").open()
  end,
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
