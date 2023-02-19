local Util = require("lazyvim.util")

return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'telescope.nvim',
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      -- Files and buffers
      { "<leader>fg", Util.telescope("git_files"), desc = "Find Git Files" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Show Buffers" },
      -- search
      { "<leader>ss", false },
      { "<leader>sf", Util.telescope("grep_string"), { cwd = Util.get_root(), shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }, desc = "Fuzzy search (cwd)" },
      { "<leader>ts", "<cmd>Telescope treesitter<cr>", desc = "Treesitter symbols" },
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      -- Git
      { "<leader>gs", false },
      { "<leader>gst", "<cmd>Telescope git_status<CR>", desc = "status" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ["<C-j>"] = {
              require('telescope.actions').move_selection_next, type = "action",
              opts = { nowait = true, silent = true }
            },
            ["<C-k>"] = {
              require('telescope.actions').move_selection_previous, type = "action",
              opts = { nowait = true, silent = true }
            },
          },
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim" -- add this value
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*"},
          path_display = {"truncate"},
          previewer = false,
          hidden = true,
          layout_config = {
            vertical = { width = 0.7 }
          },
        },
        buffers = {
          sort_lastused = true,
          sort_mru = true,
          -- ignore_current_buffer = true
        },
        git_files = {
          path_display = {"truncate"},
          layout_config = {
            vertical = { width = 0.7 }
          },
          previewer = false,
        },
        grep_string = {
        }
      },
    }
  },
}
