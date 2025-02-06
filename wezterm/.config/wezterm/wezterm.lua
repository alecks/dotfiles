local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Poimandres"

config.font = wezterm.font_with_fallback({
  "Berkeley Mono",
  -- 	"Symbols Nerd Font Mono",
})
config.font_size = 18

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
