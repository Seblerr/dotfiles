return {
  {
    'nathom/tmux.nvim',
    keys = { 'C-j', 'C-k', 'C-h', 'C-l' }
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      select = {
        -- backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
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
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map('n', '<leader>tb', gs.toggle_current_line_blame, "Toggle git blame on current line")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
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
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    }
  },

  {
    'echasnovski/mini.pick',
    version = false,
    config = function()
      require('mini.pick').setup()
    end
  },
}
