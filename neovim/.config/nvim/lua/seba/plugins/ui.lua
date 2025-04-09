return {
  {
    'nathom/tmux.nvim',
    keys = { 'C-j', 'C-k', 'C-h', 'C-l' }
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.67,
      }
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" }
    },
  }
}
