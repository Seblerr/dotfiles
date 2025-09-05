return {
  {
    'nathom/tmux.nvim',
    keys = { 'C-j', 'C-k', 'C-h', 'C-l' }
  },

  {
    "folke/zen-mode.nvim",
    opts = {
    },
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle({
            window = {
              width = .67 -- width will be 85% of the editor width
            }
          })
        end,
        desc = "ZenMode"
      }
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons',
    },
    opts = {},
}
}
