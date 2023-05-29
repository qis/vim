local dapui = require("dapui")

dapui.setup({
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  force_buffers = false,
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  layouts = {
    {
      elements = {
        { id = "repl",   size = 0.7 },
        { id = "stacks", size = 0.3 },
      },
      position = "bottom",
      size = 10,
    },
  },
  mappings = {
    edit = "e",
    expand = { "<Space>", "<2-LeftMouse>" },
    open = "<CR>",
    remove = "r",
    toggle = "t",
    repl = "c",
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})
