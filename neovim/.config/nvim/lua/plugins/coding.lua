return {
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
    event = "VeryLazy",
    opts = {
      pre_hook = function()
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      end,
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      }
    }
  },

  {
    "ggandor/leap.nvim",
    keys = {
      { "gs", false },
    }
    -- event = "VeryLazy",
    -- dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
    -- config = function(_, opts)
    --   local leap = require("leap")
    --   for k, v in pairs(opts) do
    --     leap.opts[k] = v
    --   end
    -- end,
    -- keys = {
    --   { "s", "<Plug>(leap-forward-to)", desc = "Leap forward to"},
    --   { "S", "<Plug>(leap-backward-to)", desc = "Leap backward to"},
    -- }
  },

  -- {
  --   "tzachar/local-highlight.nvim",
  --   config = function()
  --     require('local-highlight').setup({
  --       file_types = {'cc', 'cpp', 'h'},
  --       hlgroup = 'WinBarNC',
  --     })
  --   end
  -- },

  {
    "RRethy/vim-illuminate",
    opts = {
      under_cursor = false,
    }
  }
}
