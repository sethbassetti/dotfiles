-- Pull in the wezterm API
local wezterm = require("wezterm")
local projects = require("projects")

-- This will hold the configuration
config = wezterm.config_builder()

-- This is where you actually apply the config choices


-- Font and color scheme
config.color_scheme = "catppuccin-mocha"
config.font = wezterm.font("Maple Mono NF", {weight="Bold", stretch="Normal", style="Italic"})
config.font_size = 19

-- Window configs
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

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

local function move_pane(key, direction)
    return {
	key = key,
	mods = "LEADER",
	action = wezterm.action.ActivatePaneDirection(direction),
    }
end

local function resize_pane(key, direction)
    return {
	key = key,
	action = wezterm.action.AdjustPaneSize { direction, 3 }
    }
end

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
    {
	key = "'",
	mods = "LEADER",
	action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
	key = "%",
	mods = "LEADER",
	action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
	key = "a",
	mods = "LEADER|CTRL",
	action = wezterm.action.SendKey { key = "a", mods = "CTRL" },
    },
    move_pane('j', 'Down'),
    move_pane('k', 'Up'),
    move_pane('h', 'Left'),
    move_pane('l', 'Right'),
    {
	key = "r",
	mods = "LEADER",
	action = wezterm.action.ActivateKeyTable {
	    name = "resize_panes",
	    one_shot = false,
	    timeout_milliseconds = 1000,
	}
    },
    {
	key = "f",
	mods = "LEADER",
	action = wezterm.action.ShowLauncherArgs{ flags = "FUZZY|WORKSPACES" },
    },
    {
        key = "p",
	mods = "LEADER",
	action = projects.choose_project(),
    },
}

config.key_tables = {
    resize_panes = {
	resize_pane('j', 'Down'),
	resize_pane('k', 'Up'),
	resize_pane('h', 'Left'),
	resize_pane('l', 'Right'),
    },
}


-- Powerline-like status bar
-- Replace the old wezterm.on('update-status', ... function with this:

local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, _)
wezterm.log_info("status update triggered")
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg
    gradient_from = gradient_to:darken(0.2)

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

-- Finally, return the configuration to wezterm
return config
