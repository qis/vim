local bufferline = require("bufferline")
local bufferline_state = require("bufferline.state")
local bufferline_buffers = require("bufferline.buffers")
local bufdel = require('bufdel')

local function close(force)
  -- Find and delete current buffer if it is not listed shown the buffer line.
  local buffers = bufferline_buffers.get_components(bufferline_state)
  for _, name in ipairs(buffers) do
    if name.current then
      if name.id ~= vim.api.nvim_win_get_buf(0) then
        if force then
          vim.cmd("bw!")
        else
          vim.cmd("bw")
        end
        return
      end
      break
    end
  end
  -- Delete current buffer or quit.
  bufdel.delete_buffer(nil, force)
end

vim.api.nvim_create_user_command("BufferlineClose", function() close(false) end, {})
vim.api.nvim_create_user_command("BufferlineCloseForce", function() close(true) end, {})

local background = "#2D2D30"

bufferline.setup({
  options = {
    mode = "buffers",
    show_close_icon = false,
    show_buffer_close_icons = false,
    separator_style = "thin",
    custom_filter = function(i, _)
      if vim.bo[i].filetype ~= "qf" and vim.fn.bufname(i) ~= "[dap-repl]" then
        return true
      end
    end
  },
  highlights = {
    fill = { guibg = background },
    tab = {
      guibg = background,
    },
    background = {
      guifg = "#808080",
      guibg = background,
    },
    indicator_selected = {
      guifg = background,
      guibg = background,
    },
    separator_selected = {
      guifg = background,
      guibg = background,
    },
    separator_visible = {
      guifg = background,
      guibg = background,
    },
    separator = {
      guifg = background,
      guibg = background,
    },
    pick_selected = {
      guifg = background,
      guibg = background,
      gui = "none",
    },
    pick_visible = {
      guifg = background,
      guibg = background,
      gui = "none",
    },
    pick = {
      guifg = background,
      guibg = background,
      gui = "none",
    },
    buffer_selected = { gui = "none" },
    diagnostic_selected = { gui = "none" },
    info_selected = { gui = "none" },
    info_diagnostic_selected = { gui = "none" },
    warning_selected = { gui = "none" },
    warning_diagnostic_selected = { gui = "none" },
    error_selected = { gui = "none" },
    error_diagnostic_selected = { gui = "none" },
    duplicate_selected = { gui = "none" },
    duplicate_visible = { gui = "none" },
    duplicate = { gui = "none" },
  }
})
