# dotfiles

- basic [neovim](https://neovim.io) setup using [lazyvim](https://lazyvim.org)
- [wezterm](https://wezfurlong.org/wezterm/) with [Iosevka](https://github.com/be5invis/Iosevka) font
- tiling window manager setup with [yabai](https://github.com/koekeishiya/yabai)
- keybinds with [skhd](https://github.com/koekeishiya/skhd)

![image of editor](./image.png)

## installation

- `git clone github.com/alecks/dotfiles ~/.config`
- `bash ./.config/install.sh`

This script installs fonts (Iosevka and Nerd Symbols), nvim, tmux, wezterm, lazygit, skhd, yabai, and other required dependencies.

## bindings

### nvim

- leader is space
- `<leader>\` splits to the right

### tmux

- leader is `C-z`
- `<leader>-` splits below
