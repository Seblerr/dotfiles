return {

  {
    'nathom/tmux.nvim',
    keys = { 'C-j', 'C-k', 'C-h', 'C-l' }
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.nvim',
    },
    opts = {},
  },

  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function(_, opts)
      vim.keymap.set({ 'n', 'x' }, '<leader>gs', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff git status' })
      vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>CodeDiff file HEAD<cr>', { desc = 'CodeDiff git diff' })
      vim.keymap.set({ 'n', 'x' }, '<leader>gm', '<cmd>CodeDiff file master<cr>',
        { desc = 'CodeDiff git diff against master' })

      require('codediff').setup(opts)
    end
  },

  -- {
  --   "folke/flash.nvim",
  --   opts = {
  --     jump = {
  --       autojump = true
  --     },
  --     modes = {
  --       char = {
  --         autohide = true,
  --         jump_labels = true,
  --         multi_line = false,
  --       },
  --     }
  --   },
  --   keys = {
  --     { "f", "F",                      "t",                                          "T" },
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
  --     { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
  --     {
  --       "<c-s>",
  --       mode = { "c" },
  --       function() require("flash").toggle() end,
  --       desc =
  --       "Toggle Flash Search"
  --     },
  --   },
  -- },
}
