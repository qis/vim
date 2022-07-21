if vim.g.lsp_cpp then
  local dap = require("dap")
  local cmake = require("cmake")
  local path = require('plenary.path')

  vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = '', linehl = '', numhl = '' })

  local executable = path:new(os.getenv("ACE")) / "bin" / "lldb-vscode"

  dap.adapters.lldb = {
    name = "lldb",
    type = "executable",
    command = executable:absolute(),
  }

  cmake.setup({
    save_before_build = true,
    parameters_file = "build/nvim.json",
    build_dir = function()
      return "build"
    end,
    configure_args = { "--preset", "default" },
    quickfix = {
      pos = "botright",
      height = 10,
      only_on_error = false,
    },
    dap_configuration = {
      type = "lldb",
      request = "launch",
    },
    dap_open_command = dap.repl.open,
  })
end

vim.cmd("cnoreabbrev cmake CMake")

vim.api.nvim_create_user_command("CMakeShowScopes", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)

end, {})

vim.api.nvim_create_user_command("CMakeShowFrames", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end, {})

vim.api.nvim_create_user_command("CMakeShowValue", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.expression)
end, {})
