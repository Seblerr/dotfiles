return {
  {
    'echasnovski/mini.statusline',
    version = '*',
    opts = {}
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      markdown = true,
    },
  },

  {
    'echasnovski/mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    event = "VeryLazy",
    version = false,
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        custom_textobjects = {
          f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          o = spec_treesitter({
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          })
        }
      })
    end
  },

  {
    'echasnovski/mini.starter',
    version = false,
    opts = {}
  },

  {
    'echasnovski/mini.move',
    event = { "BufReadPost", "BufNewFile" },
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
          local buf = vim.api.nvim_get_current_buf()
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            local name = vim.api.nvim_buf_get_name(buf)
            mf.open(name ~= "" and name or nil)
          else
            mf.open()
          end
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
          vim.api.nvim_win_call(require('mini.files').get_explorer_state().target_window, function()
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

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
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
      vim.keymap.set({ 'n', 'x' }, '<leader>gs', '<cmd>lua MiniGit.show_at_cursor()<cr>', { desc = 'Show at cursor' })
      vim.keymap.set({ 'n', 'x' }, '<leader>ga', '<cmd>Git add %<cr>', { desc = 'Git add current file' })
      vim.keymap.set({ 'n', 'x' }, '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
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
        "<leader>di",
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
    config = function()
      require('mini.misc').setup({
        make_global = { "put", "put_text", "zoom" }
      })
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

  {
    'echasnovski/mini.trailspace',
    version = '*',
    opts = {},
  },
}
