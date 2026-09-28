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
end)

Config.now(function()
  require("mini.statusline").setup()
  require("mini.icons").setup()
  require("mini.notify").setup()
end)

Config.now_if_args(function()
  require("mini.misc").setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
end)

Config.now_if_args(function()
  require("mini.files").setup()
end)

Config.now_if_args(function()
  local completion = require('mini.completion')
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return completion.default_process_items(items, base, process_items_opts)
  end

  completion.setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  })

  Config.new_autocmd('LspAttach', '*', function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end, 'Set up mini.completion for attached LSP clients')
end)

Config.later(function()
  MiniIcons.tweak_lsp_kind()
end)

Config.later(function()
  require("mini.bufremove").setup()
  require("mini.bracketed").setup()
  require("mini.comment").setup()
  require("mini.cursorword").setup()
  require("mini.extra").setup()
  require("mini.indentscope").setup()
  require("mini.input").setup()
  require("mini.jump").setup()
  require("mini.move").setup()
  require("mini.splitjoin").setup()
  require("mini.surround").setup()
  require("mini.trailspace").setup()
  require("mini.visits").setup()
end)

Config.later(function()
  require("mini.cmdline").setup({ autocomplete = { enable = false } })
end)

Config.later(function()
  require("mini.pick").setup({
    mappings = {
      quickfix = {
        char = '<C-q>',
        func = function()
          local matches = MiniPick.get_picker_matches()
          if not matches or not matches.all or #matches.all == 0 then return end
          MiniPick.default_choose_marked(matches.all)
          return true
        end,
      },
    },
  })
end)

Config.later(function()
  local snippets = require('mini.snippets')
  snippets.setup({
    snippets = {
      snippets.gen_loader.from_lang(),
    },
  })
end)

Config.later(function()
  local keymap = require("mini.keymap")
  keymap.setup()
  local map_multistep = keymap.map_multistep
  map_multistep('i', '<Tab>', { 'minisnippets_next' })
  map_multistep('i', '<S-Tab>', { 'minisnippets_prev' })

  local map_combo = keymap.map_combo
  -- Support most common modes. This can also contain 't', but would
  -- only mean to press `<Esc>` inside terminal.
  local mode = { 'i', 'c', 'x', 's' }
  map_combo(mode, 'jk', '<BS><BS><Esc>')

  -- To not have to worry about the order of keys, also map "kj"
  map_combo(mode, 'kj', '<BS><BS><Esc>')

  -- Escape into Normal mode from Terminal mode
  map_combo('t', 'jk', '<BS><BS><C-\\><C-n>')
  map_combo('t', 'kj', '<BS><BS><C-\\><C-n>')
end)

Config.later(function()
  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
    mappings = {
      goto_first = '[C',
      goto_prev = '[c',
      goto_next = ']c',
      goto_last = ']C',
    },
  })
end)

Config.later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme     = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      todo      = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

Config.later(function()
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
end)

Config.later(function()
  local jump2d = require('mini.jump2d')
  jump2d.setup({
    labels = 'asdfghjkl',
    view = { dim = true, n_steps_ahead = 2 },
    mappings = { start_jumping = '' },
  })
end)

Config.later(function()
  -- mini.clue: show available keybindings after prefix key
  local miniclue = require('mini.clue')
  miniclue.setup({
    clues = {
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' },
      { mode = { 'n', 'x' }, keys = '[' },
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = 'i',          keys = '<C-x>' },
      { mode = { 'n', 'x' }, keys = 'g' },
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n',          keys = '<C-w>' },
      { mode = { 'n', 'x' }, keys = 's' },
      { mode = { 'n', 'x' }, keys = 'z' },
    },
  })
end)

Config.later(function()
  -- Statusline custom modes
  local statusline = require("mini.statusline")
  local default_section_mode = statusline.section_mode
  local statusline_mode_priority = {
    debug = 20,
    recording = 10,
  }

  Config.statusline_modes = {}
  Config.set_statusline_mode = function(source, text, hl)
    if text == nil then
      Config.statusline_modes[source] = nil
    else
      Config.statusline_modes[source] = {
        text = text,
        hl = hl or "MiniStatuslineModeOther",
        priority = statusline_mode_priority[source] or 0,
      }
    end
    vim.cmd("redrawstatus")
  end

  local function current_statusline_mode()
    local current
    for _, mode in pairs(Config.statusline_modes) do
      if current == nil or mode.priority > current.priority then
        current = mode
      end
    end
    return current
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_mode = function(args)
    local mode = current_statusline_mode()
    if mode ~= nil then
      return mode.text, mode.hl
    end
    return default_section_mode(args)
  end

  Config.new_autocmd("RecordingEnter", "*", function()
    Config.set_statusline_mode("recording", "REC @" .. vim.fn.reg_recording(), "MiniStatuslineModeReplace")
  end, "Show macro recording in statusline")
  Config.new_autocmd("RecordingLeave", "*", function()
    Config.set_statusline_mode("recording")
  end, "Clear macro recording from statusline")
end)

-- mini-git (standalone repo)
Config.later(function()
  vim.pack.add({ 'https://github.com/nvim-mini/mini-git' })

  require('mini.git').setup({
    command = {
      split = 'vertical',
    },
  })

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
end)
