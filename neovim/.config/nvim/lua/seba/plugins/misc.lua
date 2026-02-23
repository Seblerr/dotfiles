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

  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { "<leader>sr", function() require('grug-far').open() end,                                                     desc = "Grug - search and replace" },
      { "<leader>rw", function() require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } }) end, mode = { "n" },                    desc = "Grug - replace cword" },
      { "<leader>rw", function() require('grug-far').with_visual_selection() end,                                    mode = { "x" },                    desc = "Grug - replace visual selection" }
    },
    opts = {}
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {
      picker = {
        "buffer",
        opts = {
          hotkeys = true,
          auto_preview = true,
        },
      },
    },
    config = function(_, opts)
      require("tiny-code-action").setup(opts)
      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        require("tiny-code-action").code_action({})
      end, { noremap = true, silent = true })
    end
  }
}
