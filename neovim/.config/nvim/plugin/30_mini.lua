-- [[ Mini.nvim modules ]]
-- mini.nvim is already loaded in init.lua

-- UI-critical: needed for first screen draw
Config.now(function()
  require("mini.basics").setup({
    options = {
      extra_ui = true
    },
    mappings = {
      move_with_alt = true
    }
  })
  require("mini.statusline").setup()
  require("mini.starter").setup()
  require("mini.icons").setup()
  require("mini.notify").setup()
  require("mini.misc").setup()
  MiniMisc.setup_restore_cursor()
  require("mini.cmdline").setup({ autocomplete = { enable = false } })
end)

-- Everything else
Config.later(function()
  require("mini.move").setup()
  require("mini.bufremove").setup()
  require("mini.trailspace").setup()
  require("mini.visits").setup()
  require("mini.extra").setup()
  require("mini.jump").setup()
  require("mini.splitjoin").setup()
  require("mini.comment").setup()
  require("mini.cursorword").setup()

  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    }
  })

  require("mini.surround").setup({})
  vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

  local ai = require('mini.ai')
  require('mini.ai').setup({
    n_lines = 500,
    custom_textobjects = {
      f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      L = MiniExtra.gen_ai_spec.line(),
      B = MiniExtra.gen_ai_spec.buffer(),
      l = ai.gen_spec.treesitter({
        a = { '@loop.outer', '@conditional.outer' },
        i = { '@loop.inner', '@conditional.inner' },
      }),
    }
  })

  local jump2d = require('mini.jump2d')
  jump2d.setup({
    spotter = jump2d.gen_spotter.pattern('[^%s%p]+'),
    labels = 'asdfghjkl;',
    view = { dim = true, n_steps_ahead = 2 },
  })
  vim.keymap.set({ 'n', 'x', 'o' }, 'sj', function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end)

  vim.keymap.set('n', "<leader>bd", function() MiniBufremove.delete() end, { desc = "Remove buffer" })
  vim.keymap.set('n', "<leader>di", function() MiniDiff.toggle_overlay(0) end, { desc = "Toggle diff overlay" })
end)

-- mini.files (standalone repo)
Config.later(function()
  vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })
  require('mini.files').setup()

  vim.keymap.set('n', '<leader>e', function()
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
  end, { desc = "MiniFiles open" })

  vim.keymap.set('n', '<leader>E', function()
    local mf = require('mini.files')
    if not mf.close() then
      local git_root = Config.get_git_root()
      mf.open(git_root, false)
    end
  end, { desc = "MiniFiles open (git root)" })

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      local new_target_window
      vim.api.nvim_win_call(require('mini.files').get_explorer_state().target_window, function()
        vim.cmd(direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)
      MiniFiles.set_target_window(new_target_window)
    end
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
end)

-- mini-git (standalone repo)
Config.later(function()
  vim.pack.add({ 'https://github.com/nvim-mini/mini-git' })

  vim.keymap.set({ 'n', 'x' }, '<leader>gh', '<cmd>lua MiniGit.show_at_cursor()<cr>', { desc = 'Show at cursor' })
  vim.keymap.set({ 'n', 'x' }, '<leader>ga', '<cmd>Git add %<cr>', { desc = 'Git add current file' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gb', '<cmd>vertical Git blame -- %<cr>', { desc = 'Git blame buffer' })

  local align_blame = function(au_data)
    if au_data.data.git_subcommand ~= 'blame' then return end

    local win_src = au_data.data.win_source
    vim.wo.wrap = false
    vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

    vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniGitCommandSplit',
    callback = align_blame,
  })

  require('mini.git').setup({
    command = {
      split = 'vertical',
    },
  })
end)
