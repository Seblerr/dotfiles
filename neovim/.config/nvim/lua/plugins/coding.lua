return {
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
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          jump_labels = true,
          multi_line = false,
          highlight = {
            backdrop = false
          }
        }
      },
    },
  },

  {
    "tpope/vim-fugitive",
  },
}
