local api = require("nvim-tree.api")
local path = require("plenary.path")

local config = {
  float = false,
  close = false,
  on_attach = function(bufnr)
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Use defaults.
    api.config.mappings.default_on_attach(bufnr)

    -- Replace default preview mapping.
    vim.keymap.del('n', '<Tab>', { buffer = bufnr })
    vim.keymap.set('n', '<Space>', api.node.open.preview, opts('Open Preview'))
  end,
}

require("nvim-tree").setup({
  -- Completely disable netrw.
  -- Type: `boolean`, Default: `false`
  disable_netrw = true,

  -- Hijack netrw windows (overridden if |disable_netrw| is `true`).
  -- Type: `boolean`, Default: `true`
  hijack_netrw = true,

  -- Reloads the explorer every time a buffer is written to.
  -- Type: `boolean`, Default: `true`
  auto_reload_on_write = true,

  -- Changes how files within the same directory are sorted.
  -- Can be `name`, `case_sensitive`, `modification_time`, `extension` or a function.
  -- Type: `string` | `function(nodes)`, Default: `"name"`
  sort_by = "case_sensitive",

  -- Opens in place of the unnamed buffer if it's empty.
  -- Type: `boolean`, Default: `false`
  hijack_unnamed_buffer_when_opening = false,

  -- Keeps the cursor on the first letter of the filename when moving in the tree.
  -- Type: `boolean`, Default: `false`
  hijack_cursor = true,

  -- Preferred root directories.
  -- Only relevant when `update_focused_file.update_root` is `true`.
  -- Type: `{string}`, Default: `{}`
  root_dirs = {},

  -- Prefer startup root directory when updating root directory of the tree.
  -- Only relevant when `update_focused_file.update_root` is `true`.
  -- Type: `boolean`, Default: `false`
  prefer_startup_root = false,

  -- Changes the tree root directory on `DirChanged` and refreshes the tree.
  -- Type: `boolean`, Default: `false`
  sync_root_with_cwd = true,

  -- Automatically reloads the tree on `BufEnter` nvim-tree.
  -- Type: `boolean`, Default: `false`
  reload_on_bufenter = true,

  -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
  -- Type: `boolean`, Default: `false`
  respect_buf_cwd = false,

  -- hijacks new directory buffers when they are opened (`:e dir`).
  hijack_directories = {
    -- Enable the feature.
    -- Disable this option if you use vim-dirvish or dirbuf.nvim.
    -- If `hijack_netrw` and `disable_netrw` are `false`, this feature will be disabled.
    -- Type: `boolean`, Default: `true`
    enable = true,

    -- Opens the tree if the tree was previously closed.
    -- Type: `boolean`, Default: `true`
    auto_open = true,
  },

  -- Shows the focused file on `BufEnter`, un-collapses the folders recursively.
  update_focused_file = {
    -- Enable this feature.
    -- Type: `boolean`, Default: `false`
    enable = true,

    -- Update the root directory of the tree if the file is not under current
    -- root directory. It prefers vim's cwd and `root_dirs`.
    -- Otherwise it falls back to the folder containing the file.
    -- Only relevant when `update_focused_file.enable` is `true`
    -- Type: `boolean`, Default: `false`
    update_root = false,

    -- List of buffer names and filetypes that will not update the root dir
    -- of the tree if the file isn't found under the current root directory.
    -- Only relevant when `update_focused_file.update_root` and
    -- `update_focused_file.enable` are `true`.
    -- Type: {string}, Default: `{}`
    ignore_list = {},
  },

  -- Open a file or directory in an external application.
  system_open = {
    -- The open command itself (leave empty for OS specific default).
    -- Type: `string`, Default: `""`
    cmd = "",

    -- Optional argument list (leave empty for OS specific default).
    -- Type: {string}, Default: `{}`
    args = {},
  },

  -- Show LSP and COC diagnostics in the signcolumn
  diagnostics = {
    -- Enable the feature.
    -- Type: `boolean`, Default: `false`
    enable = false,

    -- Idle milliseconds between diagnostic event and update.
    -- Type: `number`, Default: `50` (ms)
    debounce_delay = 50,

    -- Show diagnostic icons on parent directories.
    -- Type: `boolean`, Default: `false`
    show_on_dirs = false,

    -- Show diagnostics icons on directories that are open.
    -- Only relevant when `diagnostics.show_on_dirs` is `true`.
    -- Type: `boolean`, Default: `true`
    show_on_open_dirs = true,

    -- Icons for diagnostic severity.
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },

    -- Severity for which the diagnostics will be displayed. See |diagnostic-severity|.
    severity = {
      -- Minimum severity.
      -- Type: |vim.diagnostic.severity|, Default: `vim.diagnostic.severity.HINT`
      min = vim.diagnostic.severity.HINT,

      -- Maximum severity.
      -- Type: |vim.diagnostic.severity|, Default: `vim.diagnostic.severity.ERROR`
      max = vim.diagnostic.severity.ERROR,
    },
  },

  -- Git integration with icons and colors.
  git = {
    -- Enable the feature.
    -- Type: `boolean`, Default: `true`
    enable = true,

    -- Ignore files based on `.gitignore`. Requires |git.enable| `= true`
    -- Toggle via the `toggle_git_ignored` action, default mapping `I`.
    -- Type: `boolean`, Default: `true`
    ignore = true,

    -- Show status icons of children when directory itself has no status icon.
    -- Type: `boolean`, Default: `true`
    show_on_dirs = true,

    -- Show status icons of children on directories that are open.
    -- Only relevant when `git.show_on_dirs` is `true`.
    -- Type: `boolean`, Default: `true`
    show_on_open_dirs = true,

    -- Kills the git process after some time if it takes too long.
    -- Git integration will be disabled after 10 git jobs exceed this timeout.
    -- Type: `number`, Default: `400` (ms)
    timeout = 400,
  },

  -- Indicate which file have unsaved modification.
  modified = {
    -- Enable the feature.
    -- Type: `boolean`, Default: `false`
    enable = true,

    -- Show modified indication on directory whose children are modified.
    -- Type: `boolean`, Default: `true`
    show_on_dirs = true,

    -- Show modified indication on open directories.
    -- Only relevant when |modified.show_on_dirs| is `true`.
    -- Type: `boolean`, Default: `true`
    show_on_open_dirs = true,
  },

  -- Will use file system watcher (libuv fs_event) to watch the filesystem for changes.
  -- Using this will disable BufEnter / BufWritePost events in nvim-tree which were used
  -- to update the whole tree.
  filesystem_watchers = {
    -- Enable / disable the feature.
    -- Type: `boolean`, Default: `true`
    enable = true,

    -- Idle milliseconds between filesystem change and action.
    -- Type: `number`, Default: `50` (ms)
    debounce_delay = 50,

    -- List of vim regex for absolute directory paths that will not be watched.
    -- Backslashes must be escaped e.g. `"my-project/\\.build$"`. See |string-match|.
    -- Useful when path is not in `.gitignore` or git integration is disabled.
    -- Type: {string}, Default: `{}`
    ignore_dirs = {},
  },

  -- Runs when creating the nvim-tree buffer. See |nvim-tree-mappings|.
  -- When on_attach is not a function, |nvim-tree-mappings-default| will be called.
  -- Type: `function(bufnr) | string`, Default: `"default"`
  on_attach = config.on_attach,

  -- Use |vim.ui.select| style prompts. Necessary when using a UI prompt decorator
  -- such as dressing.nvim or telescope-ui-select.nvim.
  -- Type: `boolean`, Default: `false`
  select_prompts = true,

  -- Window/Buffer setup.
  view = {
    -- When entering nvim-tree, reposition the view so that the current node is
    -- initially centralized, see |zz|.
    -- Type: `boolean`, Default: `false`
    centralize_selection = true,

    -- Enable |cursorline| in the tree window.
    -- Type: `boolean`, Default: `true`
    cursorline = true,

    -- Idle milliseconds before some reload/refresh operations.
    -- Type: `number`, Default: `15` (ms)
    debounce_delay = 15,

    -- Width of the window.
    -- Type: `string | number | function | table`, Default: `30`
    width = {
      -- Minimum dynamic width.
      -- Type: `string | number | function`, Default: `30`
      min = 30,

      -- Maximum dynamic width, -1 for unbounded.
      -- Type: `string | number | function`, Default: `-1`
      max = 30,

      -- Extra padding to the right.
      -- Type: `string | number | function`, Default: `1`
      padding = 1,
    },

    -- Side of the tree, can be `"left"`, `"right"`.
    -- Type: `string`, Default: `"left"`
    side = "left",

    -- Preserves window proportions when opening a file.
    -- If `false`, the height and width of windows other than nvim-tree will be equalized.
    -- Type: `boolean`, Default: `false`
    preserve_window_proportions = false,

    -- Print the line number in front of each line.
    -- Type: `boolean`, Default: `false`
    number = false,

    -- Show the line number relative to the line with the cursor in front of each line.
    -- If the option `view.number` is also `true`, the number on the cursor line.
    -- will be the line number instead of `0`.
    -- Type: `boolean`, Default: `false`
    relativenumber = false,

    -- Show diagnostic sign column. Value can be `"yes"`, `"auto"`, `"no"`.
    -- Type: `string`, Default: `"yes"`
    signcolumn = "yes",

    -- Configuration options for floating window.
    float = {
      -- Tree window will be floating.
      -- Type: `boolean`, Default: `false`
      enable = config.float,

      -- Close the floating tree window when it loses focus.
      -- Type: `boolean`, Default: `true`
      quit_on_focus_loss = true,

      -- Floating window config. See |nvim_open_win| for more details.
      -- Type: `table` or `function` that returns a table
      open_win_config = {
        relative = "editor",
        -- Style of window border. The values are:
        -- `"none"`, `"single"`, `"double"`, `"rounded"`, `"solid"`, `"shadow"`
        border = "rounded",
        height = 22,
        row = 1,
        col = 0,
      },
    },
  },

  -- UI rendering setup
  renderer = {
    -- Appends a trailing slash to folder names.
    -- Type: `boolean`, Default: `false`
    add_trailing = false,

    -- Compact folders that only contain a single folder into one node in the file tree.
    -- Type: `boolean`, Default: `false`
    group_empty = true,

    -- Display node whose name length is wider than the width of nvim-tree window.
    -- Type: `boolean`, Default: `false`
    full_name = false,

    -- Enable file highlight for git attributes using `NvimTreeGit*` highlight groups.
    -- Requires |nvim-tree.git.enable|
    -- Type: `boolean`, Default: `false`
    highlight_git = false,

    -- Highlight icons and names for |bufloaded()| files using the `NvimTreeOpenedFile` highlight group.
    -- Value can be `"none"`, `"icon"`, `"name"` or `"all"`.
    -- Type: `string`, Default: `"none"`
    highlight_opened_files = "name",

    -- Highlight icons and names for modified files using the `NvimTreeModifiedFile` highlight group.
    -- Requires |nvim-tree.modified.enable|.
    -- Value can be `"none"`, `"icon"`, `"name"` or `"all"`
    -- Type: `string`, Default `"none"`
    highlight_modified = "name",

    -- In what format to show root folder. See `:help filename-modifiers` for available `string` options.
    -- Set to a function that is passed the absolute path of the root folder and returns a string.
    -- Set to `false` to hide the root folder.
    -- Type: `string` or `boolean` or `function(root_cwd)`, Default: `":~:s?$?/..?"`
    root_folder_label = false,

    -- Number of spaces for an each tree nesting level. Minimum 1.
    -- Type: `number`, Default: `2`
    indent_width = 2,

    -- Configuration options for tree indent markers.
    indent_markers = {
      -- Display indent markers when folders are open.
      -- Type: `boolean`, Default: `false`
      enable = true,

      -- Display folder arrows in the same column as indent marker when
      -- using |renderer.icons.show.folder_arrow|.
      -- Type: `boolean`, Default: `true`
      inline_arrows = true,

      -- Icons shown before the file/directory. Length 1.
      -- Type: `table`, Default: `{ corner = "└", edge = "│", item = "│", bottom = "─", none = " ", }`
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },

    -- Configuration options for icons.
    icons = {
      -- Use the webdev icon colors, otherwise `NvimTreeFileIcon`.
      -- Type: `boolean`, Default: `true`
      webdev_colors = true,

      -- Place where the git icons will be rendered.
      -- Can be `"after"` or `"before"` filename (after the file/folders icons)
      -- or `"signcolumn"` (requires |nvim-tree.view.signcolumn| enabled).
      -- Type: `string`, Default: `before`
      git_placement = "signcolumn",

      -- Place where the modified icon will be rendered.
      -- Can be `"after"` or `"before"` filename (after the file/folders icons)
      -- or `"signcolumn"` (requires |nvim-tree.view.signcolumn| enabled).
      -- Type: `string`, Default: `after`
      modified_placement = "after",

      -- Inserted between icon and filename.
      -- Type: `string`, Default: `" "`
      padding = " ",

      -- Used as a separator between symlinks' source and target.
      -- Type: `string`, Default: `" ➛ "`
      symlink_arrow = " ➛ ",

      -- Configuration options for showing icon types.
      show = {
        -- Show an icon before the file name. `nvim-web-devicons` will be used if available.
        -- Type: `boolean`, Default: `true`
        file = true,

        -- Show an icon before the folder name.
        -- Type: `boolean`, Default: `true`
        folder = true,

        -- Show a small arrow before the folder node. Arrow will be a part of the
        -- node when using |renderer.indent_markers|.
        -- Type: `boolean`, Default: `true`
        folder_arrow = false,

        -- Show a git status icon, see |renderer.icons.git_placement|.
        -- Requires |git.enable| `= true`.
        -- Type: `boolean`, Default: `true`
        git = true,

        -- Show a modified icon, see |renderer.icons.modified_placement|.
        -- Requires |modified.enable| `= true`.
        -- Type: `boolean`, Default: `true`
        modified = true,
      },

      -- Configuration options for icon glyphs.
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          default = "󰉋",
          open = "󰝰",
          empty = "󰉖",
          empty_open = "󰷏",
          symlink = "󰉋",
          symlink_open = "󰝰",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },

    -- A list of filenames that gets highlighted with `NvimTreeSpecialFile`.
    -- Type: `table`, Default: `{ "Cargo.toml", "Makefile", "README.md", "readme.md", }`
    special_files = {},

    -- Whether to show the destination of the symlink.
    -- Type: `boolean`, Default: `true`
    symlink_destination = false,
  },

  -- Filtering options.
  filters = {
    -- Do not show dotfiles: files starting with a `.`.
    -- Toggle via the `toggle_dotfiles` action, default mapping `H`.
    -- Type: `boolean`, Default: `false`
    dotfiles = false,

    -- Do not show files with no git status. This will show ignored files when
    -- |nvim-tree.git.ignore| is set, as they are effectively dirty.
    -- Toggle via the `toggle_git_clean` action, default mapping `C`.
    -- Type: `boolean`, Default: `false`
    git_clean = false,

    -- Do not show files that have no |buflisted()| buffer.
    -- Toggle via the `toggle_no_buffer` action, default mapping `B`.
    -- Type: `boolean`, Default: `false`
    no_buffer = false,

    -- Custom list of vim regex for file/directory names that will not be shown.
    -- Toggle via the `toggle_custom` action, default mapping `U`.
    -- Type: {string}, Default: `{}`
    custom = { "^\\.git$" },

    -- List of directories or files to exclude from filtering: always show them.
    -- Overrides `git.ignore`, `filters.dotfiles` and `filters.custom`.
    -- Type: {string}, Default: `{}`
    exclude = {},
  },

  -- Configuration options for trashing.
  trash = {
    -- The command used to trash items (must be installed on your system).
    -- The default is shipped with glib2 which is a common linux package.
    -- Only available for UNIX.
    -- Type: `string`, Default: `"gio trash"`
    cmd = "gio trash",
  },

  -- Configuration for various actions.
  actions = {
    -- Vim |current-directory| behaviour.
    change_dir = {
      -- Change the working directory when changing directories in the tree.
      -- Type: `boolean`, Default: `true`
      enable = false,

      -- Use `:cd` instead of `:lcd` when changing directories.
      -- Consider that this might cause issues with the |nvim-tree.sync_root_with_cwd| option.
      -- Type: `boolean`, Default: `false`
      global = false,

      -- Restrict changing to a directory above the global current working directory.
      -- Type: `boolean`, Default: `false`
      restrict_above_cwd = false,
    },

    -- Configuration for expand_all behaviour.
    expand_all = {
      -- Limit the number of folders being explored when expanding every folders.
      -- Avoids hanging neovim when running this action on very large folders.
      -- Type: `number`, Default: `300`
      max_folder_discovery = 300,

      -- A list of directories that should not be expanded automatically.
      -- E.g `{ ".git", "target", "build" }` etc.
      -- Type: `table`, Default: `{}`
      exclude = { ".git", "build" },
    },

    -- Configuration for file_popup behaviour.
    file_popup = {
      -- Floating window config for file_popup. See |nvim_open_win| for more details.
      -- You shouldn't define `"width"` and `"height"` values here. They will be
      -- overridden to fit the file_popup content.
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },

    -- Configuration options for opening a file from nvim-tree.
    open_file = {
      -- Closes the explorer when opening a file.
      -- It will also disable preventing a buffer overriding the tree.
      -- Type: `boolean`, Default: `false`
      quit_on_open = config.close,

      -- Resizes the tree when opening a file.
      -- Type: `boolean`, Default: `true`
      resize_window = true,

      -- Window picker configuration.
      window_picker = {
        -- Enable the feature. If the feature is not enabled, files will open in window
        -- from which you last opened the tree.
        -- Type: `boolean`, Default: `true`
        enable = true,

        -- Change the default window picker, can be a string `"default"` or a function.
        -- The function should return the window id that will open the node,
        -- or `nil` if an invalid window is picked or user cancelled the action.
        -- The picker may create a new window.
        -- Type: `string` | `function`, Default: `"default"`
        picker = "default",

        -- A string of chars used as identifiers by the window picker.
        -- Type: `string`, Default: `"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"`
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",

        -- Table of buffer option names mapped to a list of option values that indicates
        -- to the picker that the buffer's window should not be selectable.
        -- Type: `table`
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },

    -- Configuration options for deleting a file from nvim-tree.
    remove_file = {
      -- Close any window displaying a file when removing the file from the tree.
      -- Type: `boolean`, Default: `true`
      close_window = true,
    },

    -- A boolean value that toggle the use of system clipboard when copy/paste
    -- function are invoked. When enabled, copied text will be stored in registers
    -- '+' (system), otherwise, it will be stored in '1' and '"'.
    -- Type: `boolean`, Default: `true`
    use_system_clipboard = true,
  },

  -- Configurations for the live_filtering feature.
  -- The live filter allows you to filter the tree nodes dynamically, based on
  -- regex matching (see |vim.regex|).
  -- This feature is bound to the `f` key by default.
  -- The filter can be cleared with the `F` key by default.
  live_filter = {
    -- Prefix of the filter displayed in the buffer.
    -- Type: `string`, Default: `"[FILTER]: "`
    prefix = "[FILTER]: ",

    -- Whether to filter folders or not.
    -- Type: `boolean`, Default: `true`
    always_show_folders = true,
  },

  -- Configuration for tab behaviour.
  tab = {
    -- Configuration for syncing nvim-tree across tabs.
    sync = {
      -- Opens the tree automatically when switching tabpage or opening a new
      -- tabpage if the tree was previously open.
      -- Type: `boolean`, Default: `false`
      open = true,

      -- Closes the tree across all tabpages when the tree is closed.
      -- Type: `boolean`, Default: `false`
      close = true,

      -- List of filetypes or buffer names on new tab that will prevent
      -- |nvim-tree.tab.sync.open| and |nvim-tree.tab.sync.close|
      -- Type: {string}, Default: `{}`
      ignore = {},
    },
  },

  -- General UI configuration.
  ui = {
    -- Confirmation prompts.
    confirm = {
      -- Prompt before removing.
      -- Type: `boolean`, Default: `true`
      remove = true,

      -- Prompt before trashing.
      -- Type: `boolean`, Default: `true`
      trash = true,
    },
  },
})

api.events.subscribe(api.events.Event.TreeOpen, function ()
  vim.wo.statusline = ' '
end)
