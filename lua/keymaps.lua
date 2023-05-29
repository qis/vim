-- See keymaps.vim for base keymaps.
--
-- n - NORMAL
-- i - INSERT
-- v - VISUAL
-- x - VISUAL BLOCK
-- c - COMMAND
-- t - TERMINAL
--

local keymap = vim.api.nvim_set_keymap
local simple = { noremap = true, silent = true }

-- https://github.com/nvim-telescope/telescope.nvim#pickers
local builtin = "<CMD>lua require('telescope.builtin')."

-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
local dap = "<CMD>lua require('dap')."

-- https://github.com/rcarriga/nvim-dap-ui/blob/master/doc/nvim-dap-ui.txt
local dapui = "<CMD>lua require('dapui')."

-- Open file explorer in new buffer.
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", simple)
keymap("n", "<Leader>o", ":NvimTreeToggle<CR>", simple)

-- Close buffer or window.
keymap("n", "<Leader>q", ":BufferlineClose<CR>", simple)

-- Close buffer or window (force).
keymap("n", "<Leader>x", ":BufferlineCloseForce<CR>", simple)

-- Show to next buffer tab.
keymap("i", "<M-Right>", "<C-o>:BufferLineCycleNext<CR>", simple)
keymap("n", "<M-Right>", ":BufferLineCycleNext<CR>", simple)

-- Show to previous buffer tab.
keymap("i", "<M-Left>", "<C-o>:BufferLineCyclePrev<CR>", simple)
keymap("n", "<M-Left>", ":BufferLineCyclePrev<CR>", simple)

-- Move buffer tab one slot to the right.
keymap("i", "<M-]>", "<C-o>:BufferLineMoveNext<CR>", simple)
keymap("n", "<M-]>", ":BufferLineMoveNext<CR>", simple)

-- Move buffer tab one slot to the left.
keymap("i", "<M-[>", "<C-o>:BufferLineMovePrev<CR>", simple)
keymap("n", "<M-[>", ":BufferLineMovePrev<CR>", simple)

-- Find file.
keymap("n", "<Leader>ff", builtin .. "find_files()<CR>", simple)

-- Find buffer.
keymap("n", "<Leader>fb", builtin .. "buffers()<CR>", simple)

-- Find in help.
keymap("n", "<Leader>fh", builtin .. "help_tags()<CR>", simple)

-- Grep in files.
keymap("n", "<Leader>fg", builtin .. "live_grep()<CR>", simple)

-- Find references for symbol under cursor.
keymap("n", "<Leader>fs", builtin .. "grep_string()<CR>", simple)

-- Find references for symbol under cursor in current source.
keymap("n", "<Leader>ss", builtin .. "lsp_document_symbols()<CR>", simple)

-- Find references for symbol under cursor in all sources in workspace.
keymap("n", "<Leader>sr", builtin .. "lsp_references()<CR>", simple)

-- Find users for symbol under cursor.
keymap("n", "<Leader>su", builtin .. "lsp_incoming_calls()<CR>", simple)

-- Show all symbols in workspace.
keymap("n", "<Leader>sa", builtin .. "lsp_workspace_symbols()<CR>", simple)

-- Show all symbols in workspace (dynamically).
keymap("n", "<Leader>sd", builtin .. "lsp_dynamic_workspace_symbols()<CR>", simple)

-- Cmake configuration.
keymap("n", "<Leader>cg", ":CMakeGenerate<CR>", simple)
keymap("n", "<Leader>cc", ":CMakeSelectBuildType<CR>", simple)
keymap("n", "<Leader>ct", ":CMakeSelectLaunchTarget<CR>", simple)
keymap("n", "<Leader>ca", ":CMakeLaunchArgs<CR>", simple)

-- List man pages.
keymap("i", "<F1>", "<C-o>" .. builtin .. "man_pages()<CR>", simple)
keymap("n", "<F1>", builtin .. "man_pages()<CR>", simple)

-- Switch between header and source file.
keymap("i", "<F2>", "<C-o>:ClangdSwitchSourceHeader<CR>", simple)
keymap("n", "<F2>", ":ClangdSwitchSourceHeader<CR>", simple)

-- Find definition for the symbol under cursor.
keymap("i", "<F3>", "<C-o>" .. builtin .. "lsp_definitions()<CR>", simple)
keymap("n", "<F3>", builtin .. "lsp_definitions()<CR>", simple)

-- Find definition for the type under cursor.
keymap("i", "<F4>", "<C-o>" .. builtin .. "lsp_type_definitions()<CR>", simple)
keymap("n", "<F4>", builtin .. "lsp_type_definitions()<CR>", simple)

-- Build and debug target.
keymap("i", "<F5>", "<C-o>:CMakeDebug<CR>", simple)
keymap("n", "<F5>", ":CMakeDebug<CR>", simple)

-- Stop debugging.
keymap("i", "<F6>", "<C-o>:DapTerminate<CR>", simple)
keymap("n", "<F6>", ":DapTerminate<CR>", simple)

-- Build all targets.
keymap("i", "<F7>", "<C-o>:CMakeBuild<CR>", simple)
keymap("n", "<F7>", ":CMakeBuild<CR>", simple)

-- Debugger: Continue.
keymap("i", "<F8>", "<C-o>" .. dap .. "continue()<CR>", simple)
keymap("n", "<F8>", dap .. "continue()<CR>", simple)

-- Debugger: Step out.
keymap("i", "<F9>", "<C-o>" .. dap .. "step_out()<CR>", simple)
keymap("n", "<F9>", dap .. "step_out()<CR>", simple)

-- Debugger: Step over.
keymap("i", "<F10>", "<C-o>" .. dap .. "step_over()<CR>", simple)
keymap("n", "<F10>", dap .. "step_over()<CR>", simple)

-- Debugger: Step into.
keymap("i", "<F11>", "<C-o>" .. dap .. "step_into()<CR>", simple)
keymap("n", "<F11>", dap .. "step_into()<CR>", simple)

-- Toggle debugger ui.
keymap("i", "<F12>", "<C-o>" .. dapui .. "toggle()<CR>", simple)
keymap("n", "<F12>", dapui .. "toggle()<CR>", simple)

-- Toggle breakpoint.
keymap("n", "<Leader>b", dap .. "toggle_breakpoint()<CR>", simple)

-- Show diagnostics for current source.
keymap("n", "<Leader>dd", builtin .. "diagnostics({ bufnr = 0 })<CR>", simple)

-- Show diagnostics for all sources in workspace.
keymap("n", "<Leader>da", builtin .. "diagnostics()<CR>", simple)

-- Show debugger stacks.
keymap("n", "<Leader>ds", dapui .. "float_element('stacks', { enter = true })<CR>", simple)

-- Show debugger value for symbol under cursor.
keymap("n", "<Leader>dv", dapui .. "eval(nil, { enter = true })<CR>", simple)

-- Show debugger breakpoints.
keymap("n", "<Leader>db", dapui .. "float_element('breakpoints', { enter = true })<CR>", simple)

-- Show debugger watches.
keymap("n", "<Leader>dw", dapui .. "float_element('watches', { enter = true })<CR>", simple)

-- Show git changes per file with diff preview.
-- Add:         RETURN
keymap("n", "<Leader>gg", builtin .. "git_status()<CR>", simple)

-- Show git log for current file with diff preview.
-- Checkout:    RETURN
keymap("n", "<Leader>gl", builtin .. "git_bcommits()<CR>", simple)

-- Show git log for all files with diff preview.
-- Checkout:    RETURN
-- Reset mixed: CTRL+R M
-- Reset soft:  CTRL+R S
-- Reset hard:  CTRL+R H
keymap("n", "<Leader>ga", builtin .. "git_commits()<CR>", simple)

-- Show git checkout options with log preview.
-- Checkout:    RETURN
-- Rebase:      CTRL+R
-- Track:       CTRL+T
keymap("n", "<Leader>gc", builtin .. "git_branches()<CR>", simple)

-- Show git stash items in current repository.
-- Apply:       RETURN
keymap("n", "<Leader>gs", builtin .. "git_stash()<CR>", simple)
