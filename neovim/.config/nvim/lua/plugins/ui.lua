-- bufferline
return {
  -- { 'numToStr/Navigator.nvim' },
  { 'nathom/tmux.nvim' },
  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      opts.sections.lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, shorting_target = 75, symbols = { modified = "  ", readonly = "", unnamed = "" } },
      }
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["o"] = "open",
        },
      },
    },
  },
  { 'Bekaboo/deadcolumn.nvim' },

  -- {
  --   "chrisgrieser/nvim-early-retirement",
  --   config = true,
  --   event = "VeryLazy",
  -- },
}
