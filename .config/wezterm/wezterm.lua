-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
config = wezterm.config_builder()

-- This is where you actually apply the config choices

-- Font and color scheme
config.color_scheme = "catppuccin-mocha"
config.font = wezterm.font("Maple Mono NF", {weight="Bold", stretch="Normal", style="Italic"})
config.font_size = 19

-- Window configs
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 5

-- Finally, return the configuration to wezterm
return config

