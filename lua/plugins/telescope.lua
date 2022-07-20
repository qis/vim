local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.99,
        height = 0.99,
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
