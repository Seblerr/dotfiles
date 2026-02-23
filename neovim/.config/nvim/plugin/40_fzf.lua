Config.later(function()
  vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

  local fzf = require("fzf-lua")
  local actions = fzf.actions

  fzf.setup({
    "ivy",
    fzf_colors = true,
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    winopts = {
      backdrop = 80,
      border = "rounded",
      preview = {
        hidden = true,
        scrollchars = { "┃", "" }
      },
    },
    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
      }
    },
    defaults = {
      file_icons = "mini"
    },
    files = {
      formatter = "path.dirname_first",
      actions = {
        ["ctrl-i"] = actions.toggle_ignore,
        ["ctrl-h"] = actions.toggle_hidden
      }
    },
    buffers = {
      formatter = "path.filename_first",
    },
    grep = {
      hidden = true,
      actions = {
        ["ctrl-i"] = actions.toggle_ignore,
        ["ctrl-h"] = actions.toggle_hidden
      },
    },
    git = {
      files = {
        formatter = "path.dirname_first",
      },
    }
  })
  fzf.register_ui_select()

  vim.keymap.set('n', '<leader><leader>', '<Cmd>FzfLua files<CR>', { desc = "FzfLua files" })
  vim.keymap.set('n', '<leader>ff', '<Cmd>FzfLua files<CR>', { desc = "FzfLua files" })
  vim.keymap.set('n', '<leader>fF', function()
    local git_root = Config.get_git_root()
    require('fzf-lua').files({ cwd = git_root })
  end, { desc = "FzfLua files (git root)" })
  vim.keymap.set('n', '<leader>fg', '<Cmd>FzfLua git_files<CR>', { desc = "FzfLua git files" })
  vim.keymap.set('n', '<leader>,', '<Cmd>FzfLua buffers<CR>', { desc = "FzfLua buffers" })
  vim.keymap.set('n', '<leader>sg', '<Cmd>FzfLua grep<CR>', { desc = "FzfLua grep" })
  vim.keymap.set('n', '<leader>sG', function()
    local git_root = Config.get_git_root()
    require('fzf-lua').grep({ cwd = git_root })
  end, { desc = "FzfLua grep git repo" })
  vim.keymap.set('n', '<leader>fc', '<Cmd>FzfLua files cwd=~/.dotfiles/<CR>', { desc = "FzfLua dotfiles" })
  vim.keymap.set('n', '<leader>fr', '<Cmd>FzfLua oldfiles<CR>', { desc = "FzfLua oldfiles" })
  vim.keymap.set('n', '<leader>sf', '<Cmd>FzfLua live_grep<CR>', { desc = "FzfLua live grep (fuzzy)" })
  vim.keymap.set('n', '<leader>sb', '<Cmd>FzfLua grep_curbuf<CR>', { desc = "FzfLua fuzzy grep current buffer" })
  vim.keymap.set('n', ',', '<Cmd>FzfLua lgrep_curbuf<CR>', { desc = "FzfLua grep current buffer" })
  vim.keymap.set('n', '<leader>sw', '<Cmd>FzfLua grep_cword<CR>', { desc = "FzfLua current word" })
  vim.keymap.set('x', '<leader>sw', '<Cmd>FzfLua grep_visual<CR>', { desc = "FzfLua grep visual selection" })
  vim.keymap.set('n', '<leader>sr', '<Cmd>FzfLua resume<CR>', { desc = "FzfLua resume" })
  vim.keymap.set('n', '<leader>sd', '<Cmd>FzfLua diagnostics_document<CR>', { desc = "Diagnostics document" })
  vim.keymap.set('n', '<leader>sk', '<Cmd>FzfLua keymaps<CR>', { desc = "Search keymaps" })
  vim.keymap.set('n', '<leader>sh', '<Cmd>FzfLua helptags<CR>', { desc = "Search help" })
  vim.keymap.set('n', '<leader>gl', '<Cmd>FzfLua git_bcommits<CR>', { desc = "FzfLua git log (buffer)" })
  vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', { desc = "LSP references" })
  vim.keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>', { desc = "LSP definition" })
  vim.keymap.set('n', 'gD', '<cmd>FzfLua lsp_declarations<cr>', { desc = "LSP declarations" })
  vim.keymap.set('n', '<leader>D', '<cmd>FzfLua typedefs<cr>', { desc = "LSP type definition" })
  vim.keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations<cr>', { desc = "LSP implementations" })
  vim.keymap.set('n', 'ga', '<cmd>FzfLua lsp_finder<cr>', { desc = "LSP finder (all)" })
  vim.keymap.set('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', { desc = "LSP code actions" })
  vim.keymap.set('n', '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', { desc = "LSP document symbols" })
  vim.keymap.set('n', '<leader>sS', '<cmd>FzfLua lsp_workspace_symbols<cr>', { desc = "LSP workspace symbols" })
end)
