# (N)Vim Configuration
Minimal (N)Vim configuration.

## Windows
Clone repository and install fonts.

```cmd
cd %UserProfile%
git clone https://github.com/qis/vim vimfiles
```

Configure `vim` and `nvim` in WSL.

```sh
USERPROFILE="$(/bin/wslpath -a $(${CMD} /C 'echo %UserProfile%' 2>/dev/null | sed 's/\r//g') 2>/dev/null)"
sudo rm -rf /etc/vim /etc/xdg/nvim
sudo ln -s "${USERPROFILE}/vimfiles" /etc/vim
sudo ln -s /etc/vim /etc/xdg/nvim
sudo touch /root/.viminfo
touch ~/.viminfo
```

## FreeBSD/Darwin/Linux
Clone repository and create symlink to `~/.vim`.

```sh
sudo rm -rf /etc/vim /etc/xdg/nvim
sudo git clone  https://github.com/qis/vim /etc/vim
sudo ln -s /etc/vim /etc/xdg/nvim
sudo touch /root/.viminfo
touch ~/.viminfo
```

Configure desktop integration.

```sh
sudo apt install fonts-dejavu fonts-ipaexfont

cat > ~/.local/share/applications/defaults.list <<'EOF'
[Default Applications]
text/plain=gvim.desktop
text/xml=gvim.desktop
text/x-chdr=gvim.desktop
text/x-csrc=gvim.desktop
text/x-c++hdr=gvim.desktop
text/x-c++src=gvim.desktop
text/x-qml=gvim.desktop
EOF

sudo update-alternatives --install /usr/bin/gnome-text-editor gnome-text-editor /usr/bin/gvim 100
sudo apt purge gedit
```

<details>
<summary><b>C/C++ Development</b></summary>

Install packages.

```sh
sudo apt install binutils-dev gdb make nasm ninja-build
sudo apt install clang-11 llvm-11 lld-11 libc++-11-dev libc++abi-11-dev
sudo apt install clang-format-11 clang-tidy-11 clangd-11 lldb-11
```

Configure alternatives.

```sh
for i in clang{,++,d} clang-{cpp,format,tidy} lld llvm-{ar,nm,ranlib}; do
  sudo update-alternatives --remove-all $i 2>/dev/null
  sudo update-alternatives --install /usr/bin/$i $i /usr/bin/$i-11 100
done
```

Install plugins for C/C++ development.

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat > ~/.vimrc <<'EOF'
" Plugins
let g:coc_config_home = '~/.vim'

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': [ 'h', 'hpp', 'c', 'cpp' ] }
Plug 'rhysd/vim-clang-format', { 'for': [ 'h', 'hpp', 'c', 'cpp' ] }
call plug#end()

" Colors
colorscheme codedark
let g:airline_theme = 'codedark'
hi link LspCxxHlGroupNamespace Normal
hi link LspCxxHlGroupMemberVariable Normal

" Formatting
let g:clang_format#auto_format = 1
nnoremap <Leader>d :<C-u>ClangFormat<CR>
EOF
```

Start `vim(1)` and install plugins.

```vim
:PlugInstall
:CocInstall coc-clangd
```

Create settings.

```sh
cat > ~/.vim/coc-settings.json <<'EOF'
{
  "clangd.enabled": true,
  "clangd.semanticHighlighting": true,
  "clangd.arguments": [ "--compile-commands-dir", "build" ]
}
EOF
```

</details>
