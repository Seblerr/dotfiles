return {
  {
    'echasnovski/mini.ai',
    event = "VeryLazy",
    version = false,
    opts = function()
      local ai = require('mini.ai')
      local spec_treesitter = ai.gen_spec.treesitter
      return {
        n_lines = 500,
        custom_textobjects = {
          f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
          i = spec_treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
        }
      }
    end
  },

  {
    'echasnovski/mini.move',
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = {},
  },

  {
    'echasnovski/mini.pairs',
    event = "InsertEnter",
    version = false,
    opts = {},
  },

  {
    'echasnovski/mini.surround',
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = {
      mappings = {
        add = 'gsa',            -- Add surrounding in Normal and Visual modes
        delete = 'gsd',         -- Delete surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        replace = 'gsr',        -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      }
    }
  },

  {
    'echasnovski/mini.files',
    version = '*',
    keys = {
      { "<leader>o", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", "MiniFiles open" },
    },
    opts = {}
  },
}
