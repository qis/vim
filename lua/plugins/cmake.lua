local canonical = require("canonical")

require("cmake").setup({
  save_before_build = true,
  parameters_file = "build/nvim.json",
  build_dir = canonical(vim.loop.cwd()) .. "/build",
  configure_args = { "--preset", "default" },
  quickfix = {
    pos = "botright",
    height = 10,
    only_on_error = false,
  },
  dap_configuration = { type = "lldb", request = "launch" },
  dap_open_command = require("dap").repl.open,
})
