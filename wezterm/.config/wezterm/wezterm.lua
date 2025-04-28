local wezterm = require 'wezterm'

return {
  color_scheme = 'catppuccin-mocha',
  font_size = 14,

  window_padding = {
    left = '0.3cell',
    right = '0.3cell',
    top = '0.25cell',
    bottom = '0.25cell',
  },

  audible_bell = "Disabled",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  max_fps = 120,


  disable_default_key_bindings = true,
  keys = {
    { key = '+', mods = 'CTRL',       action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CTRL',       action = wezterm.action.DecreaseFontSize },
    { key = '0', mods = 'CTRL',       action = wezterm.action.ResetFontSize },
    { key = 'c', mods = 'SHIFT|CTRL', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
    {
      key = 'Backspace',
      mods = 'CTRL',
      action = wezterm.action({ SendKey = { key = 'w', mods = 'CTRL' } }),
    }
  }
}
