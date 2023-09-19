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
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      overrides = {
        -- Add highlight for vim-illuminate instead of underline
        IlluminatedWordText = { bg = "#3c3836" },
        IlluminatedWordRead = { bg = "#3c3836" },
        IlluminatedWordWrite = { bg = "#3c3836" },
      },
    },
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  }
}
