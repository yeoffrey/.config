local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.color_scheme = "Tokyo Night Moon"

config.max_fps = 144

-- Temp fix for Wezterm on nixpkgs
config.front_end = "WebGpu"

return config
