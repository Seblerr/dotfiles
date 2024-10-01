return {
  {
    'echasnovski/mini.ai',
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    version = false,
    config = function()
      local gen_spec = require('mini.ai').gen_spec
      require('mini.ai').setup({
        n_lines = 100,
        custom_textobjects = {
          f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
          i = gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
        }
      })
    end
  },

  {
    'echasnovski/mini.starter',
    version = false,
    opts = {}
  },

  -- {
  --   'echasnovski/mini.pick',
  --   event = "VeryLazy",
  --   version = false,
  --   config = function()
  --     require('mini.pick').setup()
  --   end
  -- },

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
    'echasnovski/mini.files',
    version = false,
    dependencies = 'echasnovski/mini.icons',
    keys = {
      { "<leader>e", function()
        local mf = require('mini.files')
        if not mf.close() then
          mf.open(vim.api.nvim_buf_get_name(0))
        end
      end, "MiniFiles open" },
      { "<leader>E", function()
        local mf = require('mini.files')
        if not mf.close() then
          local git_root = require('seba.util').get_git_root()
          mf.open(git_root, false)
        end
      end, "MiniFiles open" },
    },
    config = function()
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(require('mini.files').get_target_window(), function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, 'gs', 'belowright vertical')
        end,
      })
      require('mini.files').setup()
    end
  },

  {
    'echasnovski/mini-git',
    event = "VeryLazy",
    version = false,
    main = 'mini.git',
    opts = {
      command = {
        split = 'vertical',
      },
    },
    config = function(_, opts)
      local rhs = '<Cmd>lua MiniGit.show_at_cursor()<CR>'
      vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Show at cursor' })
      vim.keymap.set({ 'n', 'x' }, '<leader>gb', '<cmd>vertical Git blame -- %<cr>', { desc = 'Git blame buffer' })
      vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>vertical Git diff -- %<cr>', { desc = 'Git diff buffer' })

      local align_blame = function(au_data)
        if au_data.data.git_subcommand ~= 'blame' then return end

        -- Align blame output with source
        local win_src = au_data.data.win_source
        vim.wo.wrap = false
        vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
        vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

        -- Bind both windows so that they scroll together
        vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
      end

      local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }
      vim.api.nvim_create_autocmd('User', au_opts)

      require('mini.git').setup(opts)
    end

  },

  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>go",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },

  {
    'echasnovski/mini.notify',
    version = '*',
    config = function()
      require('mini.notify').setup()
      vim.notify = require('mini.notify').make_notify()
    end
  },

  {
    'echasnovski/mini.icons',
    version = false,
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end
  },

  {
    'echasnovski/mini.misc',
    version = false,
    event = "VeryLazy",
    keys = {
      { "<leader>z", "<cmd>lua zoom()<cr>", desc = "Zoom split" }
    },
    config = function()
      require('mini.misc').setup({
        make_global = { "put", "put_text", "zoom" }
      })
      -- MiniMisc.setup_auto_root()
      -- MiniMisc.setup_termbg_sync()
      MiniMisc.setup_restore_cursor()
    end
  },

  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup({
        symbol = "│",
        options = {
          try_as_border = true
        },
        draw = {
          delay = 100,
          priority = 2,
          animation = function(s, n)
            return s / n * 20
          end
        }
      })
    end
  },
}
