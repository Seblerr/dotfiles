return {
  -- {
  --   'navarasu/onedark.nvim',
  --    opts = { style = "warm" },
  --
  -- },

  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
          -- Add highlight for vim-illuminate instead of underline
          IlluminatedWordText = { bg = "#3c3836" },
          IlluminatedWordRead = { bg = "#3c3836" },
          IlluminatedWordWrite = { bg = "#3c3836" },
        },
    }
  },

  -- {
  --   'folke/tokyonight.nvim',
  --    opts = { style = "moon" },
  --
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox"
    }
  }
}
