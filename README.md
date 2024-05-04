# dotfiles

- basic [neovim](https://neovim.io) setup using [lazyvim](https://lazyvim.org)
- pretty [tmux](https://github.com/tmux/tmux/wiki) config using [catppuccin](https://github.com/catppuccin/tmux)
- kitty terminal with [Iosevka](https://github.com/be5invis/Iosevka) font
- uses the [kanagawa-dragon](https://github.com/rebelot/kanagawa.nvim) theme

![image of editor](./image.png)

## installation

- `git clone github.com/alecks/dotfiles ~/.config`
- `bash ./.config/install.sh`

This script installs fonts (Iosevka and Nerd Symbols), nvim, kitty, tmux, lazygit and other required dependencies.

## usage

I usually don't use tmux with vim since it's a hassle getting spell-check underlines and italics to work --- I edit markdown often. Kitty is good enough as a multiplexer for almost all cases.

Includes the [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) plugin which I use really often for notes.

## bindings

### nvim

- leader is space
- `<leader>\` splits to the right

### tmux

- leader is `C-z`
- `<leader>-` splits below
