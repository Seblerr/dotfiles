return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  {
    "folke/flash.nvim",
    opts = {
      jump = {
        autojump = true
      },
      modes = {
        char = {
          autohide = true,
          jump_labels = true,
          multi_line = false,
        },
      }
    },
    keys = {
      { "f", "F",                      "t",                                          "T" },
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },


  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    priority = 49,
    dependencies = {
      "saghen/blink.cmp"
    },
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { "<leader>sr", function() require('grug-far').open() end,                                                     desc = "Grug - search and replace" },
      { "<leader>rw", function() require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } }) end, mode = { "n" },                    desc = "Grug - replace cword" },
      { "<leader>rw", function() require('grug-far').with_visual_selection() end,                                    mode = { "x" },                    desc = "Grug - replace visual selection" }
    },
    opts = {}
  }
}
