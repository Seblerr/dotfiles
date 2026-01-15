return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader><leader>", "<Cmd>FzfLua files<CR>", desc = "FzfLua files" },
    { "<leader>ff",       "<Cmd>FzfLua files<CR>", desc = "FzfLua files" },
    {
      "<leader>fF",
      function()
        local git_root = require('seba.util').get_git_root()
        require('fzf-lua').files({ cwd = git_root })
      end,
      desc = "FzfLua files (git root)"
    },
    { "<leader>fg", "<Cmd>FzfLua git_files<CR>", desc = "FzfLua git files" },
    { "<leader>,",  "<Cmd>FzfLua buffers<CR>",   desc = "FzfLua buffers" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",      desc = "FzfLua grep" },
    {
      "<leader>sG",
      function()
        local git_root = function()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end
        local root = git_root()
        require('fzf-lua').grep({ cwd = root })
      end,
      desc = "FzfLua grep git repo"
    },
    { "<leader>fc", "<Cmd>FzfLua files cwd=~/.dotfiles/<CR>", desc = "FzfLua files" },
    { "<leader>fr", "<Cmd>FzfLua oldfiles<CR>",               desc = "FzfLua oldfiles" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",                   desc = "FzfLua grep" },
    { "<leader>sf", "<Cmd>FzfLua live_grep<CR>",              desc = "FzfLua live grep (fuzzy)" },
    { "<leader>sb", "<Cmd>FzfLua grep_curbuf<CR>",            desc = "FzfLua fuzzy grep current buffer" },
    { ",",          "<Cmd>FzfLua lgrep_curbuf<CR>",           desc = "FzfLua grep current buffer" },
    { "<leader>sw", "<Cmd>FzfLua grep_cword<CR>",             mode = { "n" },                           desc = "FzfLua current word" },
    { "<leader>sw", "<Cmd>FzfLua grep_visual<CR>",            mode = { "x" },                           desc = "FzfLua grep visual selection" },
    { "<leader>sr", "<Cmd>FzfLua resume<CR>",                 desc = "FzfLua resume" },
    { "<leader>sd", "<Cmd>FzfLua diagnostics_document<CR>",   desc = "Diagnostics document" },
    { "<leader>sk", "<Cmd>FzfLua keymaps<CR>",                desc = "Search keymaps" },
    { "<leader>sh", "<Cmd>FzfLua helptags<CR>",               desc = "Search help" },
    { "<leader>gl", "<Cmd>FzfLua git_bcommits<CR>",           desc = "FzfLua git log (buffer)" },
    { "gr",         "<cmd>FzfLua lsp_references<cr>",         desc = "LSP references" },
    { "gd",         "<cmd>FzfLua lsp_definitions<cr>",        desc = "LSP definition" },
    { "gD",         "<cmd>FzfLua lsp_declarations<cr>",       desc = "LSP declarations" },
    { "<leader>D",  "<cmd>FzfLua typedefs<cr>",               desc = "LSP type definition" },
    { "gi",         "<cmd>FzfLua lsp_implementations<cr>",    desc = "LSP implementations" },
    { "ga",         "<cmd>FzfLua lsp_finder<cr>",             desc = "LSP finder (all)" },
    { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>",       desc = "LSP document symbols" },
    { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>",   desc = "LSP document symbols" },
    { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>",  desc = "LSP workspace symbols" },
  },
  config = function()
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
    -- fzf.register_ui_select(ui_select)
  end
}
