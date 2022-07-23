local nvim_tree = require("nvim-tree")
local nvim_tree_core = require("nvim-tree.core")
local nvim_tree_view = require("nvim-tree.view")
local nvim_tree_renderer = require("nvim-tree.renderer")
local bufferline_state = require("bufferline.state")
local bufferline_buffers = require("bufferline.buffers")

local nvim_tree_actions_refresh = require("nvim-tree.actions.reloaders.reloaders").reload_explorer
local nvim_tree_actions_find_file = require("nvim-tree.actions.finders.find-file").fn

local function close()
  local buffers = bufferline_buffers.get_components(bufferline_state)
  if (buffers and #buffers > 0) then
    nvim_tree_view.close()
  else
    vim.cmd("quit")
  end
end

local function tree(buffer)
  if nvim_tree_view.is_visible() then
    return
  end

  local file = nil
  local path = vim.loop.cwd()
  local buffers = bufferline_buffers.get_components(bufferline_state)
  for _, name in ipairs(buffers) do
    if name:current() then
      file = name.path
      break
    end
  end

  if buffer then
    vim.api.nvim_command("enew")
  else
    vim.api.nvim_command("tabnew")
  end
  if not nvim_tree_core.get_explorer() or path ~= nvim_tree_core.get_cwd() then
    nvim_tree_core.init(path)
  end

  nvim_tree_view.open_in_current_win({ hijack_current_buf = true, resize = false })
  nvim_tree_renderer.draw()

  if file ~= nil then
    local stat = vim.loop.fs_stat(file)
    if stat ~= nil and stat.type == "file" then
      nvim_tree_actions_find_file(file)
    end
  end
  nvim_tree_actions_refresh()
end

vim.api.nvim_create_user_command("NvimTreeBuffer", function() tree(true) end, {})
vim.api.nvim_create_user_command("NvimTreeTab", function() tree(false) end, {})

local function git()
  vim.api.nvim_command("enew")
  vim.api.nvim_command("Git ++curwin diff")
end

vim.api.nvim_create_user_command("NvimTreeGit", git, {})

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = { "^\\.git$", "^build$" },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = true,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>", "<2-LeftMouse>" }, action = "edit_in_place" },
        { key = "<Leader>q", action = "close", action_cb = close },
        { key = "q", action = "close", action_cb = close },
      },
    },
    number = false,
    relativenumber = false,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "name",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    },
    indent_markers = {
      enable = true,
    },
    special_files = {},
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false,
      },
    },
  },
})
