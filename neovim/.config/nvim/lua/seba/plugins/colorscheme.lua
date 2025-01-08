return {
  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  --

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   opts = {
  --     overrides = {
  --       -- Add highlight for vim-illuminate instead of underline
  --       IlluminatedWordText = { bg = "#3c3836" },
  --       IlluminatedWordRead = { bg = "#3c3836" },
  --       IlluminatedWordWrite = { bg = "#3c3836" },
  --     },
  --   },
  --   config = function()
  --     vim.cmd.colorscheme 'gruvbox'
  --   end,
  -- }
}
