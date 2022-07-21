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

-- Switch to left buffer or tab with "ALT+Left".
keymap("i", "<M-Left>", "<C-o>:BufferLineCyclePrev<CR>", simple)
keymap("n", "<M-Left>", ":BufferLineCyclePrev<CR>", simple)

-- Switch to right buffer or tab with "ALT+Right".
keymap("i", "<M-Right>", "<C-o>:BufferLineCycleNext<CR>", simple)
keymap("n", "<M-Right>", ":BufferLineCycleNext<CR>", simple)

-- Move buffer or tab to the left with "ALT+[".
keymap("i", "<M-[>", "<C-o>:BufferLineMovePrev<CR>", simple)
keymap("n", "<M-[>", ":BufferLineMovePrev<CR>", simple)

-- Move buffer or tab to the right with "ALT+]".
keymap("i", "<M-]>", "<C-o>:BufferLineMoveNext<CR>", simple)
keymap("n", "<M-]>", ":BufferLineMoveNext<CR>", simple)

-- Close buffer or tab with "LEADER Q".
keymap("n", "<Leader>q", ":BufferlineClose<CR>", simple)

-- Force close buffer or tab with "LEADER X".
keymap("n", "<Leader>x", ":BufferlineCloseForce<CR>", simple)

-- Open file browser in new buffer with "LEADER (E|O)".
keymap("n", "<Leader>e", ":NvimTreeBuffer<CR>", simple)
keymap("n", "<Leader>o", ":NvimTreeBuffer<CR>", simple)

-- Open file browser in new tab with "LEADER T".
keymap("n", "<Leader>t", ":NvimTreeTab<CR>", simple)

-- Toggle git diff view with "LEADER G" (see "Telescope" section).
--keymap("n", "<Leader>g", ":NvimTreeGit<CR>", simple)

-- Use clang-format on file or selection with "LEADER F".
keymap("n", "<Leader>f", ":ClangFormat<CR>", simple)
keymap("v", "<Leader>f", ":ClangFormat<CR>", simple)

-- Telescope --
-- https://github.com/nvim-telescope/telescope.nvim#pickers
-- Toggle selection with "TAB".
-- Close with "CTRL+C".
local builtin = "<CMD>lua require('telescope.builtin')."

-- [F]ind [F]iles.
keymap("n", "<Leader>ff", builtin .. "find_files()<CR>", simple)

-- [F]ind with [G]rep.
keymap("n", "<Leader>fg", builtin .. "live_grep()<CR>", simple)

-- [F]ind [B]buffer.
keymap("n", "<Leader>fb", builtin .. "buffers()<CR>", simple)

-- [F]ind in [H]elp.
keymap("n", "<Leader>fh", builtin .. "help_tags()<CR>", simple)

-- [F]ind [R]eferences for word under cursor.
keymap("n", "<Leader>fw", builtin .. "grep_string()<CR>", simple)

-- LSP: [S]earch document symbols in the current buffer.
keymap("n", "<Leader>ss", builtin .. "lsp_document_symbols()<CR>", simple)

-- LSP: [S]earch [R]eferences for word under cursor.
keymap("n", "<Leader>sr", builtin .. "lsp_references()<CR>", simple)

-- LSP: [S]earch [U]sers for word under the cursor.
keymap("n", "<Leader>su", builtin .. "lsp_incoming_calls()<CR>", simple)

-- LSP: [S]earch for [A]ll workspace symbols.
keymap("n", "<Leader>sa", builtin .. "lsp_workspace_symbols()<CR>", simple)

-- LSP: [S]earch for all workspace symbols [D]ynamically.
keymap("n", "<Leader>sd", builtin .. "lsp_dynamic_workspace_symbols()<CR>", simple)

-- LSP: Lists [D]iagnostics for current buffer.
keymap("n", "<Leader>dd", builtin .. "diagnostics({ bufnr = 0 })<CR>", simple)

-- LSP: Lists [D]iagnostics for [A]ll buffers.
keymap("n", "<Leader>da", builtin .. "diagnostics()<CR>", simple)

-- LSP: Go to the definition of the word under the cursor.
keymap("n", "<F12>", builtin .. "lsp_definitions()<CR>", simple)

-- LSP: Go to the definition of the type of the word under the cursor.
keymap("n", "<S-F12>", builtin .. "lsp_type_definitions()<CR>", simple)

-- Git: List [G]it changes per file with diff preview.
-- Add:         RETURN
keymap("n", "<Leader>gg", builtin .. "git_status()<CR>", simple)

-- Git: Show [G]it [L]og for current buffer with diff preview.
-- Checkout:    RETURN
keymap("n", "<Leader>gl", builtin .. "git_bcommits()<CR>", simple)

-- Git: Show [G]it log for [A]ll files with diff preview.
-- Checkout:    RETURN
-- Reset mixed: CTRL+R M
-- Reset soft:  CTRL+R S
-- Reset hard:  CTRL+R H
keymap("n", "<Leader>ga", builtin .. "git_commits()<CR>", simple)

-- Git: Show [G]it [C]heckout options with log preview.
-- Checkout:    RETURN
-- Rebase:      CTRL+R
-- Track:       CTRL+T
keymap("n", "<Leader>gc", builtin .. "git_branches()<CR>", simple)

-- Git: Show [G]it [S]tash items in current repository.
-- Apply:       RETURN
keymap("n", "<Leader>gs", builtin .. "git_stash()<CR>", simple)

-- CMake --
local cmake = "<CMD>lua require('cmake')."

-- [C]Make: Select [C]onfig.
keymap("n", "<Leader>cc", cmake .. "select_config()<CR>", simple)

-- [C]Make: Select [T]arget.
keymap("n", "<Leader>ct", cmake .. "select_target()<CR>", simple)

-- [C]Make: Set target [A]rguments.
keymap("n", "<Leader>ca", cmake .. "set_target_arguments()<CR>", simple)

-- [C]Make: Build and debug with "F5".
keymap("n", "<F5>", cmake .. "build_and_debug()<CR>", simple)

-- [C]Make: Build and run with "F6".
keymap("n", "<F6>", cmake .. "build_and_run()<CR>", simple)

-- [C]Make: build all with "F7".
keymap("n", "<F7>", cmake .. "build_all()<CR>", simple)

-- Debug --
local dap = "<CMD>lua require('dap')."

-- Debug: Toggle [B]reakpoint.
keymap("n", "<Leader>b", dap .. "toggle_breakpoint()<CR>", simple)

-- Debug: Continue with "F8".
keymap("n", "<F8>", dap .. "continue()<CR>", simple)

-- Debug: Step out, over, in with "F9", "F10", "F11".
keymap("n", "<F9>", dap .. "step_out()<CR>", simple)
keymap("n", "<F10>", dap .. "step_over()<CR>", simple)
keymap("n", "<F11>", dap .. "step_into()<CR>", simple)

-- Debug: Look up symbol under cursor with "F12".
keymap("n", "<F12>", dap .. "repl.open()<CR>", simple)
