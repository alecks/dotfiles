# nvim setup

This is a really basic [lazy-vim](https://lazyvim.org) setup, pretty much unchanged from the starter repo.

It also includes a tmux and iTerm2 config, all using the [catppuccin](https://github.com/catppuccin) theme.

![image of editor](./image.png)

## installation for nvim

- `git clone github.com/alecks/nvim-setup ~/.config/nvim`
- `brew install ripgrep lazygit`

## then for tmux

- `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- run `C-I` and `C-r` in tmux
- `cp ~/.config/nvim/other/.tmux.conf ~/.tmux.conf`

## bindings

### nvim

- leader is space
- `<leader>\` splits to the right

### tmux

- leader is `C-z`
- `<leader>-` splits below
