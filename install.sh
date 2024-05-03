#!/bin/sh
curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf -o ~/Library/Fonts/SymbolsNerdFont-Regular.ttf
brew tap homebrew/cask-fonts
brew install nvim tmux kitty ripgrep lazygit font-iosevka
ln -s ~/.config/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "DONE"
echo "- next steps: run tmux and nvim"
