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
