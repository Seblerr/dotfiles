return {
  {
    'nathom/tmux.nvim',
    keys = { 'C-j', 'C-k', 'C-h', 'C-l' }
  },

  {
    'stevearc/dressing.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      select = {
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
      }
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    version = false,
    dependencies = 'echasnovski/mini.icons',
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      return {
        options = {
          theme = 'auto',
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
          ignore_focus = {
            "dapui_watches", "dapui_breakpoints",
            "dapui_scopes", "dapui_console",
            "dapui_stacks", "dap-repl"
          }
        },
        sections = {
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, shorting_target = 75, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          }
        }
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    opts = {
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" }
    },
  }
}
