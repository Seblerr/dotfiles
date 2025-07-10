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
  }
}
