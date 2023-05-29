require("cmake-tools").setup({
  cmake_command = (function()
    local path = require("plenary.path")
    local file = vim.fn.exepath((path:new(os.getenv("ACE")) / "bin" / "cmake").filename)
    return vim.loop.fs_stat(file) and file or vim.fn.exepath("cmake")
  end)(),
  cmake_build_directory = "",
  cmake_build_directory_prefix = "build-",
  cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=ON" },
  cmake_soft_link_compile_commands = false,
  cmake_regenerate_on_save = false,
  cmake_build_options = {},
  cmake_console_size = 16,
  cmake_console_position = "belowright",
  cmake_show_console = "always",
  cmake_dap_configuration = {
    name = "cpp",
    type = "lldb",
    request = "launch",
    runInTerminal = false,
  },
  cmake_variants_message = {
    short = { show = true },
    long = { show = true, max_length = 40 }
  }
})
