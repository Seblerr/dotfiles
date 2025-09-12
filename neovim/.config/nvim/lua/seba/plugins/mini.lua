return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    keys = {
      { "<leader>bd", function() MiniBufremove.delete() end,     desc = "Remove buffer" },
      { "<leader>di", function() MiniDiff.toggle_overlay(0) end, desc = "Remove buffer" },
    },
    config = function()
      require("mini.statusline").setup()
      require("mini.starter").setup()
      require("mini.move").setup()
      require("mini.bufremove").setup()
      require("mini.icons").setup()
      require("mini.notify").setup()
      require("mini.misc").setup()
      require("mini.trailspace").setup()
      require("mini.visits").setup()
      require("mini.extra").setup()
      require("mini.jump").setup()
      require("mini.splitjoin").setup()

      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = {
            add = "▎",
            change = "▎",
            delete = "",
          },
        }
      })

      require("mini.surround").setup({
        mappings = {
          add = 'gsa',            -- Add surrounding in Normal and Visual modes
          delete = 'gsd',         -- Delete surrounding
          find = 'gsf',           -- Find surrounding (to the right)
          find_left = 'gsF',      -- Find surrounding (to the left)
          highlight = 'gsh',      -- Highlight surrounding
          replace = 'gsr',        -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`
        }
      })

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

      MiniMisc.setup_restore_cursor()
    end
  },

  {
    'nvim-mini/mini.files',
    version = false,
    dependencies = 'nvim-mini/mini.icons',
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

      require('mini.files').setup()
    end
  },

  {
    'nvim-mini/mini-git',
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
    'nvim-mini/mini.pick',
    version = false,
    opts = {
      mappings = {
        to_quickfix = {
          char = "<c-q>",
          func = function()
            local items = MiniPick.get_picker_items() or {}
            MiniPick.default_choose_marked(items)
            MiniPick.stop()
          end,
        },
      }
    },
    keys = {
      {
        "<leader>fc",
        function()
          MiniPick.builtin.cli(
            {
              command = { "rg", "--files", "--hidden", "--glob=!.git/" }
            },
            { source = { cwd = "~/.dotfiles" } }
          )
        end,
        desc = "Pick dotfiles",
      },
      { "<leader><leader>", "<cmd>Pick files<cr>",                        desc = "Search Files" },
      { "<leader>ff",       "<cmd>Pick files<cr>",                        desc = "Search Files" },
      { "<leader>fg",       "<cmd>Pick git_files<cr>",                    desc = "Git files" },
      { "<leader>fr",       "<cmd>Pick visit_paths<cr>",                  desc = "Previous files" },
      { "<leader>,",        "<cmd>Pick buffers<cr>",                      desc = "Pick buffers" },
      { "<leader>sg",       "<cmd>Pick grep<cr>",                         desc = "Pick grep" },
      { "<leader>sw",       "<cmd>Pick grep pattern='<cword>'<cr>",       desc = "Grep current word" },
      { "<leader>sf",       "<cmd>Pick grep_live<cr>",                    desc = "Live Grep" },
      { "<leader>sk",       "<cmd>Pick keymaps<cr>",                      desc = "[S]earch [K]eymaps" },
      { "<leader>sh",       "<cmd>Pick help<cr>",                         desc = "[S]earch [H]elp" },
      { "<leader>sm",       "<cmd>Pick marks<cr>",                        desc = "[S]earch [M]arks" },
      { "<leader>sd",       "<cmd>Pick diagnostic<cr>",                   desc = "[S]earch [D]iagnostics" },
      { "<leader>sR",       "<cmd>Pick resume<cr>",                       desc = "[S]earch [R]esume" },
      { "<leader>gl",       "<cmd>Pick git_commits<cr>",                  desc = "Git commits" },
      { "gr",               "<cmd>Pick lsp scope='references'<cr>",       desc = "LSP references" },
      { "gd",               "<cmd>Pick lsp scope='definition'<cr>",       desc = "LSP definition" },
      { "<leader>ss",       "<cmd>Pick lsp scope='document_symbol'<cr>",  desc = "LSP document symbols" },
      { "<leader>sS",       "<cmd>Pick lsp scope='workspace_symbol'<cr>", desc = "LSP workspace symbols" },
    },
    config = function(_, opts)
      require("mini.pick").setup(opts)
      vim.ui.select = require("mini.pick").ui_select
    end
  }
}
