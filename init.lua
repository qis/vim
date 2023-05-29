-- Options
vim.opt.backup = false
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.scrolloff = 1
vim.opt.shiftwidth = 2
vim.opt.showmode = true
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.writebackup = false

-- Tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 8

-- Special Characters
vim.opt.fillchars:append "stl: ,stlnc: ,"
vim.opt.listchars="tab:»·,extends:»,precedes:«,nbsp:␣"
vim.opt.list = true

-- Gutter
vim.opt.foldcolumn = "1"
vim.opt.signcolumn = "yes:1"

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append "c"

-- Color Scheme
vim.cmd("colorscheme core")

-- Bugfixes
-- https://github.com/neovim/neovim/issues/20456
vim.cmd("autocmd! ColorScheme,VimEnter * highlight! link markdownError Normal | highlight! link luaError Normal")

-- Keymaps
require("keymaps")

-- Plugins
-- https://github.com/nvim-lua/plenary.nvim
vim.cmd("packadd plenary")

-- https://github.com/ojroques/nvim-bufdel
vim.cmd("packadd bufdel")

-- https://github.com/kyazdani42/nvim-web-devicons
vim.cmd("packadd nvim-web-devicons")
require("plugins.nvim-web-devicons")

-- https://github.com/akinsho/bufferline.nvim
vim.cmd("packadd bufferline")
require("plugins.bufferline")

-- https://github.com/folke/trouble.nvim
vim.cmd("packadd trouble")
require("plugins.trouble")

-- https://github.com/lewis6991/gitsigns.nvim
vim.cmd("packadd gitsigns")
require("plugins.gitsigns")

-- https://github.com/nvim-lua/popup.nvim
vim.cmd("packadd popup")

-- https://github.com/L3MON4D3/LuaSnip
vim.cmd("packadd luasnip")

-- https://github.com/hrsh7th/cmp-nvim-lsp
vim.cmd("packadd cmp_nvim_lsp")

-- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
vim.cmd("packadd cmp_nvim_lsp_signature_help")

-- https://github.com/hrsh7th/nvim-cmp
vim.cmd("packadd cmp")
require("plugins.cmp")

-- https://github.com/neovim/nvim-lspconfig
vim.cmd("packadd lspconfig")
require("plugins.lspconfig")

-- https://github.com/nvim-treesitter/nvim-treesitter
vim.cmd("packadd nvim-treesitter")
require("plugins.nvim-treesitter")

-- https://github.com/kyazdani42/nvim-tree.lua
vim.cmd("packadd nvim-tree")
require("plugins.nvim-tree")

-- https://github.com/rhysd/vim-clang-format
vim.cmd("packadd clang-format")

-- https://github.com/mfussenegger/nvim-dap
vim.cmd("packadd dap")
require("plugins.dap")

-- https://github.com/rcarriga/nvim-dap-ui
vim.cmd("packadd dapui")
require("plugins.dapui")

-- https://github.com/nvim-telescope/telescope-dap.nvim
vim.cmd("packadd telescope-dap")

-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
vim.cmd("packadd telescope-fzf-native")

-- https://github.com/nvim-telescope/telescope.nvim
vim.cmd("packadd telescope")
require("plugins.telescope")

-- https://github.com/Civitasv/cmake-tools.nvim
vim.cmd("packadd cmake-tools")
require("plugins.cmake-tools")
