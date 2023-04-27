return {
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
    -- event = "VeryLazy",
    -- opts = {
    --   pre_hook = function()
    --     require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    --   end,
    -- },
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
  },

  {
    "tpope/vim-fugitive",
  },



  -- {
  --   "RRethy/vim-illuminate",
  --   opts = {
  --     under_cursor = false,
  --   }
  -- }
}
