return {
  {
    "monkoose/neocodeium",
    enabled = false,
    opts = {
      filetypes = {
        ["dap-repl"] = false,
        dapui_watches = false,
        DressingInput = false,
        snacks_picker_input = false,
      }
    },
    config = function(_, opts)
      local neocodeium = require("neocodeium")

      vim.keymap.set("i", "<A-f>", function()
        neocodeium.accept()
      end)
      vim.keymap.set("i", "<A-w>", function()
        neocodeium.accept_word()
      end)
      vim.keymap.set("i", "<A-a>", function()
        neocodeium.accept_line()
      end)
      vim.keymap.set("i", "<A-e>", function()
        neocodeium.cycle_or_complete()
      end)
      vim.keymap.set("i", "<A-q>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-c>", function()
        neocodeium.clear()
      end)

      neocodeium.setup(opts)
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
      },
    },
  },

}
