#!/bin/sh

# download nerd fonts
curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf -o ~/Library/Fonts/SymbolsNerdFont-Regular.ttf
# install packages
brew tap homebrew/cask-fonts
brew install wezterm nvim tmux ripgrep lazygit font-iosevka koekeishiya/formulae/skhd koekeishiya/formulae/yabai
# tmux
ln -s ~/.config/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "DONE"
echo "next steps:"
echo "-- run yabai --start-service to start yabai, give permissions, then run yabai --restart-service"
echo "-- repeat this with skhd --start-service then skhd --restart-service"
echo "-- run tmux & nvim"
