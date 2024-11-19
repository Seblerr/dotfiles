local wezterm = require 'wezterm'

return {
  color_scheme = 'catppuccin-macchiato',

  font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = 'Medium' },
    { family = "Symbols Nerd Font Mono",  scale = 0.67 }
  }),
  font_size = 14,

  audible_bell = "Disabled",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  max_fps = 120,
  animation_fps = 120,

  keys = {
    {
      key = 'Backspace',
      mods = 'CTRL',
      action = wezterm.action({ SendKey = { key = 'w', mods = 'CTRL' } }),
    }
  }
}
