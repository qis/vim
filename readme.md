# Vim
Configuration files for `vim(1)` and `nvim(1)`.

```sh
sudo mv /etc/vim /etc/vim.orig
sudo git clone https://github.com/qis/vim /etc/vim
```

<details>
<summary>Keys</summary>

```
# General
[ NVX ] c                 # Copy character or selection to clipboard.
[ NVX ] CTRL + c          # Copy character or selection to clipboard.
[INVXC] CTRL + p          # Paste from clipboard.
[INVXC] SHIFT + INSERT    # Paste from clipboard.
[INVXC] INSERT            # Paste from clipboard.
[ N   ] u                 # Undo last change.
[ N   ] r                 # Redo last change.
[IN   ] CTRL + l          # Clear serach.
[I    ] CTRL + DEL        # Delete word after cursor.
[I    ] CTRL + BACKSPACE  # Delete word before cursor.
[IN   ] CTRL + UP         # Move to the beginning of a function.
[IN   ] CTRL + DOWN       # Move to the end of a function.
[IN   ] HOME              # Go to the first character or beginning of the line.
[INVX ] ALT + UP          # Move line or selected lines up.
[INVX ] ALT + DOWN        # Move line or selected lines down.
[INVX ] SHIFT + UP        # Move screen one line up.
[INVX ] SHIFT + DOWN      # Move screen one line down.
[INVX ] SHIFT + PG UP     # Move screen 1/2 page up.
[INVX ] SHIFT + PG DOWN   # Move screen 1/2 page down.
[ N   ] TAB               # Focus next window.

# Buffers
[IN   ] CTRL + s          # Write buffer.
[ N   ] \w                # Write buffer.
[ N   ] \e                # Open file explorer in new buffer.
[ N   ] \o                # Open file explorer in new buffer.
[ N   ] \t                # Open file explorer in new tab.
[ N   ] \q                # Close buffer or window.
[ N   ] \x                # Close buffer or window (force).
[IN   ] ALT + RIGHT       # Show to next buffer tab.
[IN   ] ALT + LEFT        # Show to previous buffer tab.
[IN   ] ALT + ]           # Move buffer tab one slot to the right.
[IN   ] ALT + [           # Move buffer tab one slot to the left.

# Find
[ N   ] \ff               # Find file.
[ N   ] \fb               # Find buffer.
[ N   ] \fh               # Find in help.
[ N   ] \fg               # Grep in files.
[ N   ] \fs               # Find references for symbol under cursor.

# Find (LSP)
[ N   ] \ss               # Find references for symbol under cursor in current source.
[ N   ] \sr               # Find references for symbol under cursor in all sources in workspace.
[ N   ] \su               # Find users for symbol under cursor.
[ N   ] \sa               # Show all symbols in workspace.
[ N   ] \sd               # Show all symbols in workspace (dynamically).

[ N   ] F1                # List man pages.
[ N   ] F2                # Switch between header and source file.
[ N   ] F3                # Find definition for the symbol under cursor.
[ N   ] F4                # Find definition for the type under cursor.

# Telescope
[     ] CTRL + /          # Show key mappings and help.

# Building
[     ] :cmake            # Configure project.
[     ] :cmake build      # Build target.
[     ] :cmake clean      # Clean project.

[ N   ] \cc               # Select config.
[ N   ] \ct               # Select target.
[ N   ] \ca               # Set target arguments.

[IN   ] F5                # Build and debug target.
[IN   ] F6                # Build and run target without debugging.
[IN   ] F7                # Build all targets.

# Debugging
[ N   ] \b                # Toggle breakpoint.
[ N   ] \dd               # Show diagnostics for current source.
[ N   ] \da               # Show diagnostics for all sources in workspace.
[ N   ] \ds               # Show debugger scopes.
[ N   ] \df               # Show debugger frames.
[ N   ] \dt               # Show debugger threads.
[ N   ] \dv               # Show value for symbol under cursor.

[ N   ] F8                # Debugger: Continue.
[ N   ] F9                # Debugger: Step out.
[ N   ] F10               # Debugger: Step over.
[ N   ] F11               # Debugger: Step into.
[ N   ] F12               # Debugger: Show output window.

# Formatting
[ NVX ] >                 # Increase line or selection indentation.
[ NVX ] <                 # Decrease line or selection indentation.
[ NVX ] \\                # Toggle comment status of line or block.
[ NV  ] \cf               # Run clang-format on file or selection.

# Git
[     ] :git <command>    # Execute git command.

[ N   ] \gb               # Toggle git blame view.
[ N   ] \gg               # Show git changes per file with diff preview.
[ N   ] \gl               # Show git log for current file with diff preview.
[ N   ] \ga               # Show git log for all files with diff preview.
[ N   ] \gc               # Show git checkout options with log preview.
[ N   ] \gs               # Show git stash items in current repository.

# Info
[ N   ] \.                # Show syntax highlight under cursor.
```

</details>

## Nvim
Install [ace](https://github.com/qis/ace) and [fonts](https://github.com/qis/fonts).

<details>
<summary>Linux</summary>

```sh
# Install tools.
sudo apt install -y --no-install-recommends \
  nodejs npm python3 python3-pip fd-find ripgrep

# Configure npm.
npm config set prefix ~/.npm
sudo tee /etc/profile.d/npm.sh >/dev/null <<'EOF'
export PATH="${PATH}:${HOME}/.npm/bin"
EOF
sudo chmod 0755 /etc/profile.d/npm.sh
. /etc/profile.d/npm.sh

# Install NPM packages.
npm install -g typescript typescript-language-server eslint prettier terser
npm install -g rollup @rollup/plugin-typescript rollup-plugin-terser
npm install -g rollup-plugin-serve rollup-plugin-livereload neovim

# Install PIP packages.
pip install neovim

# Install nvim(1).
make -C /opt/ace dev

# Install config.
git clone --recursive https://github.com/qis/vim ~/.config/nvim

# Install fzf and treesitter binaries.
curl -L https://github.com/qis/vim/releases/download/1.0.0/nvim-lib-linux.tar.gz -o nvim-lib.tar.gz
tar xf nvim-lib.tar.gz -C ~/.config/nvim

# Register nvim.
sudo tee /etc/profile.d/nvim.sh >/dev/null <<'EOF'
export PATH="/opt/ace/dev/bin:${PATH}"
EOF
sudo chmod 0755 /etc/profile.d/nvim.sh
. /etc/profile.d/nvim.sh
```

</details>

<details>
<summary>Windows</summary>

Install dependencies.

* [Node.js][njs]
* [Python 3][py3]
* [Chocolatey][cho]

Install dependencies in `Windows PowerShell (Admin)`.

```ps1
# Install tools.
choco install fd ripgrep

# Install NPM packages.
npm install -g typescript typescript-language-server eslint prettier terser
npm install -g rollup @rollup/plugin-typescript rollup-plugin-terser
npm install -g rollup-plugin-serve rollup-plugin-livereload neovim

# Install PIP packages.
pip install neovim
```

Install `nvim(1)` in `Command Prompt`.

```sh
make -C C:/Ace dev
```

Install config.

```cmd
git clone --recursive https://github.com/qis/vim %LocalAppData%\nvim
```

Install `fzf` and `treesitter` binaries.

```cmd
curl -L https://github.com/qis/vim/releases/download/1.0.0/nvim-lib-windows.tar.gz -o nvim-lib.tar.gz
tar xf nvim-lib.tar.gz -C %LocalAppData%\nvim
```

Execute `C:\Ace\src\nvim.cmd` to add `nvim-qt.exe` to the Explorer context menu.

Execute `C:\Ace\src\nvim.ps1` to associate file extensions with `nvim-qt.exe`.

</details>

## Nvim Build
Build `fzf` and `treesitter` binaries from source.

<details>
<summary>Linux</summary>

```sh
# Rename shared libc++ library.
mv /opt/ace/sys/x86_64-pc-linux-gnu/lib/libc++.so \
   /opt/ace/sys/x86_64-pc-linux-gnu/lib/libc++.so.orig

# Install telescope fzf plugin.
cd ~/.config/nvim/pack/plugins/opt/telescope-fzf-native
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cmake --install build --prefix build
cmake -E rename build/libfzf.so libfzf.so
cmake -E remove_directory build
cmake -E make_directory build
cmake -E rename libfzf.so build/libfzf.so

# Install treesitter libraries.
nvim
```

```
:TSInstall c
:TSInstall cpp
:TSInstall lua
:TSInstall javascript
:TSInstall typescript
```

```sh
# Restore shared libc++ library.
mv /opt/ace/sys/x86_64-pc-linux-gnu/lib/libc++.so.orig \
   /opt/ace/sys/x86_64-pc-linux-gnu/lib/libc++.so
```

</details>

<details>
<summary>Windows</summary>

Install [Visual Studio 2022][vsc] and select the "**Desktop development with C++**"
package in the left pane. Remove all default selections in the right pane except:
- "**MSVC v143 - VS 2022 C++ x64/x86 build tools**" (default)
- "**C++ ATL for latest v143 build tools**" (default)
- "**Windows 11 SDK**" (latest version)

Install dependencies in `x64 Native Tools Command Prompt for VS 2022`.

```cmd
rem Install telescope fzf plugin.
cd %LocalAppData%\nvim\pack\plugins\opt\telescope-fzf-native
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cmake --install build --prefix build
cmake -E rename build/libfzf.dll libfzf.dll
cmake -E remove_directory build
cmake -E make_directory build
cmake -E rename libfzf.dll build/libfzf.dll

rem Install treesitter libraries.
nvim
```

```
:TSInstall c
:TSInstall cpp
:TSInstall lua
:TSInstall javascript
:TSInstall typescript
```

</details>

<!--
## Plugins
* <https://github.com/tpope/vim-commentary> (v1.3, patched)
* <https://github.com/tpope/vim-fugitive> (v3.7)
* <https://github.com/chr4/nginx.vim> (HEAD)
-->

## TAB
Use [uncap](https://github.com/susam/uncap) to remap `TAB` to `ESC` on Windows.

[njs]: https://nodejs.org/
[py3]: https://www.python.org/downloads/windows/
[cho]: https://chocolatey.org/
[vsc]: https://visualstudio.microsoft.com/downloads/
