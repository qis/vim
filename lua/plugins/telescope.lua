local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = function(_, cx) return cx end,
        height = function(_, cy) return cy end,
      },
    },
    sorting_strategy = "ascending",
  },
  extensions = {
    fzf = {
      fuzzy = true,
    },
  },
})

telescope.load_extension("fzf")
--telescope.load_extension("dap")
