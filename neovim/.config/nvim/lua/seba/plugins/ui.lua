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
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
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
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      stages = "static",
      timeout = 1500,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
}
