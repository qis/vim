require("dapui").setup({
  layouts = {
    {
      elements = {
        { id = "repl", size = 0.75 },
        { id = "watches", size = 0.25 },
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
})
