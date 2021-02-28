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
EOF

sudo update-alternatives --install /usr/bin/gnome-text-editor gnome-text-editor /usr/bin/gvim 100
sudo apt purge gedit
```
