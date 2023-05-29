# Vim
Configuration files for `vim(1)` and `nvim(1)`.

```sh
sudo mv /etc/vim /etc/vim.orig
sudo git clone https://github.com/qis/vim /etc/vim
```

See [doc/keymaps.txt](doc/keymaps.txt) or use `:help keymaps` for key bindings.

## Nvim
Install [fonts](https://github.com/qis/fonts).

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

# Install config.
git clone --recursive https://github.com/qis/vim ~/.config/nvim

# Register nvim.
sudo tee /etc/profile.d/nvim.sh >/dev/null <<'EOF'
export PATH="/opt/ace/dev/bin:${PATH}"
EOF
sudo chmod 0755 /etc/profile.d/nvim.sh
. /etc/profile.d/nvim.sh
```

</details>

## Nvim Build
Build `fzf` and `treesitter` binaries from source.

```sh
# Install telescope fzf plugin.
cd ~/.config/nvim/pack/plugins/opt/telescope-fzf-native
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cmake --install build --prefix build
mv build/libfzf.so libfzf.so
rm -rf build
mkdir build
mv libfzf.so build/libfzf.so

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
