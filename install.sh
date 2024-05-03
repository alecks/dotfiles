#!/bin/sh
brew install nvim tmux kitty ripgrep lazygit
ln -s ~/.config/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "DONE"
echo "- next steps: run tmux and nvim"
