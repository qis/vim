local nvim_treesitter_configs = require("nvim-treesitter.configs")

nvim_treesitter_configs.setup({
  ensure_installed = {},
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = false },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
