return {
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {
  --     strategies = {
  --       chat = {
  --         adapter = "gemini",
  --       },
  --       inline = {
  --         adapter = "gemini",
  --       },
  --     }
  --   }
  -- },

  {
    "folke/sidekick.nvim",
    -- dependencies = {
    --   { "zbirenbaum/copilot.lua", opts = {}, cmd = "Copilot" }
    -- },
    opts = {
      -- nes = {
      --   enabled = false
      -- },
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        tools = {
          gemini = { cmd = { "gemini" }, url = "https://github.com/google-gemini/gemini-cli" },
        }
      },
    },
    keys = {
      {
        "<tab>",
        function()
          if require("sidekick").nes_jump_or_apply() then
            return
          end

          -- if you are using Neovim's native inline completions
          if vim.lsp.inline_completion.get() then
            return
          end

          return "<tab>"
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Gemini Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  }
}
