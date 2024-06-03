return {
  {
    'echasnovski/mini.ai',
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
    opts = {}
  },

  {
    'echasnovski/mini-git',
    version = false,
    main = 'mini.git',
    opts = {
      command = {
        split = 'vertical',
      },
    },
    config = function(_, opts)
      local rhs = '<Cmd>lua MiniGit.show_at_cursor()<CR>'
      vim.keymap.set({ 'n', 'x' }, '<Leader>gs', rhs, { desc = 'Show at cursor' })
      vim.keymap.set({ 'n', 'x' }, '<Leader>gb', '<Cmd>vertical Git blame -- %<CR>', { desc = 'Git blame buffer' })

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
}
