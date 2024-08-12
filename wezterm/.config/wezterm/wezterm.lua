local wezterm = require 'wezterm'

return {
  -- General settings
  color_scheme = 'catppuccin-macchiato',

  font = wezterm.font_with_fallback({
    { family = "JetBrainsMono NF",       weight = 'Medium' },
    { family = "Symbols Nerd Font Mono", scale = 0.67 }
  }),
  font_size = 14,

  enable_tab_bar = false,

  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",

  audible_bell = "Disabled",

}
