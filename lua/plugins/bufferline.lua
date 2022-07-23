local bufferline = require("bufferline")
local bufferline_state = require("bufferline.state")
local bufferline_buffers = require("bufferline.buffers")
local bufdel = require('bufdel')

local function close(force)
  -- Close top telescrope or debug info window.
  for _, i in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[i].filetype == "TelescopePrompt" or vim.bo[i].filetype == "dap-float" then
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(w) == i then
          vim.api.nvim_win_close(w, true)
          break
        end
      end
      return
    end
  end

  -- Close windows with dap and cmake buffers.
  local closed = false
  for _, i in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[i].filetype == "qf" or vim.fn.bufname(i) == "[dap-repl]" then
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(w) == i then
          vim.api.nvim_win_close(w, true)
          closed = true
          break
        end
      end
      vim.api.nvim_buf_delete(i, { force = true })
    end
  end
  if closed then
    return
  end

  -- Find and delete current buffer if it is not shown in the buffer line.
  local buffers = bufferline_buffers.get_components(bufferline_state)
  for _, name in ipairs(buffers) do
    if name:current() then
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
