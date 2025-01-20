local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- config.color_scheme = "iTerm2 Default"
config.colors = { foreground = "white" }

-- config.font = wezterm.font("JetBrains Mono")
-- config.font_size = 12
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"
return config
