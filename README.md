# dotfiles

Dotfiles for my personal Mac and my university's DICE computers. 

## Installation with stow-all

This repository has a `stow-all.sh` script which can be used to install all packages from a `stowlist`. For example, `./stow-all.sh stowlist-dice` will install everything used for DICE.

## Shared

- [Helix](https://helix-editor.com) code editor (attempt 2 at swtiching from nvim)
- [Ghostty](https://ghostty.org) terminal
- [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono) typeface
- [Poimandres](https://github.com/drcmda/poimandres-theme) colourscheme for dark mode, ported for many things
- Gruvbox colourscheme for light mode (use `scripts/toggle-theme.sh` to switch)

See `stowlist-shared`.

## Mac

- [Aerospace](https://github.com/nikitabobko/AeroSpace) tiling window manager
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) status bar
- [Karabiner Elements](http://karabiner-elements.pqrs.org/) for hyperkey with CapsLock

![image of macos setup](./screenshots/mac.jpg)

See `stowlist-mac`.

## DICE

- [i3](https://i3wm.org) window manager, with i3status and [picom](https://picom.app)
- [infpi](https://github.com/alecks/infpi) for local package management, with the ability to use Nix (see dice-login)

![image of dice setup](./screenshots/dice.png)

See `stowlist-dice`. The DICE dotfiles should work on an unmodified DICE install, with no extra programs downloaded. Picom is optional for less screen tearing, but is a pain to install.
