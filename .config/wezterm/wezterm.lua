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
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Tab bar settings
config.window_frame = {
    font = wezterm.font("Maple Mono NF", {weight="Bold", stretch="Normal", style="Italic"}),
    font_size = 14

}

-- Key bindings
config.keys = {
    {
	-- When the left arrow key is pressed
	key = "LeftArrow",
	-- With the "Option" key modifier held down
	mods = "OPT",
	-- Perform this action, in this case sending ESC + B to the terminal
	action = wezterm.action.SendString '\x1bb',
    },
    {
	key = "RightArrow",
	mods = "OPT",
	action = wezterm.action.SendString '\x1bf',
    },
    {
	key = ",",
	mods = "SUPER",
	action = wezterm.action_callback(function(window, pane)
        -- Spawn the tab first
        window:perform_action(
          wezterm.action.SpawnCommandInNewTab {
            cwd = wezterm.home_dir,
            args = { "vim", wezterm.config_file },
          },
          pane
        )

        -- Wait a tiny bit to set the title after the tab spawns
        wezterm.sleep_ms(100)

        local tab = window:active_tab()
        if tab then
          tab:set_title("Settings")
        end
      end),
    },
}

-- Powerline-like status bar
wezterm.on('update-status', function(window)
    -- Grab the utf8 character for the "powerline" left facing
    -- solid arrow.
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Grab the current window's configuration
    local color_scheme = window:effective_config().resolved_palette
    local bg = color_scheme.background
    local fg = color_scheme.foreground

    window:set_right_status(wezterm.format({
        -- First, draw the arrow
        { Background = {Color = 'none' } },
        { Foreground = {Color = bg } },
        { Text = SOLID_LEFT_ARROW},
	
	-- Then we draw our text
	{ Background = {Color = bg }},
	{ Foreground = {Color = fg }},
	{ Text = " " .. wezterm.hostname() .. " " },
   
   }))
end)

-- Finally, return the configuration to wezterm
return config
 
