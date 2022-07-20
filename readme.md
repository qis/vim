# Vim
Configuration files for `vim(1)` and `nvim(1)`.

```sh
sudo mv /etc/vim /etc/vim.orig
sudo git clone https://github.com/qis/vim /etc/vim
```

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

## TAB
Use [uncap](https://github.com/susam/uncap) to remap `TAB` to `ESC` on Windows.

[njs]: https://nodejs.org/
[py3]: https://www.python.org/downloads/windows/
[cho]: https://chocolatey.org/
[vsc]: https://visualstudio.microsoft.com/downloads/
