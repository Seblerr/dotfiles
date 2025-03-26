return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<Cmd>FzfLua files<CR>",                  desc = "FzfLua files" },
    {
      "<leader>fF",
      function()
        local git_root = require('seba.util').get_git_root()
        require('fzf-lua').files({ cwd = git_root })
      end,
      desc = "FzfLua files (git root)"
    },
    { "<leader>fg", "<Cmd>FzfLua git_files<CR>",              desc = "FzfLua git files" },
    { "<leader>,",  "<Cmd>FzfLua buffers<CR>",                desc = "FzfLua buffers" },
    { "<leader>fp", "<Cmd>FzfLua files cwd=~/.dotfiles/<CR>", desc = "FzfLua files" },
    { "<leader>?",  "<Cmd>FzfLua oldfiles<CR>",               desc = "FzfLua oldfiles" },
    { "<leader>gl", "<Cmd>FzfLua git_bcommits<CR>",           desc = "FzfLua git log (buffer)" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",                   desc = "FzfLua grep" },
    { "<leader>sf", "<Cmd>FzfLua live_grep<CR>",              desc = "FzfLua live grep (fuzzy)" },
    { "<leader>sb", "<Cmd>FzfLua grep_curbuf<CR>",            desc = "FzfLua fuzzy grep current buffer" },
    { "<leader>/",  "<Cmd>FzfLua lgrep_curbuf<CR>",           desc = "FzfLua grep current buffer" },
    { "<leader>sw", "<Cmd>FzfLua grep_cword<CR>",             mode = { "n" },                           desc = "FzfLua current word" },
    { "<leader>sw", "<Cmd>FzfLua grep_visual<CR>",            mode = { "x" },                           desc = "FzfLua grep visual selection" },
    { "<leader>sr", "<Cmd>FzfLua resume<CR>",                 desc = "FzfLua resume" },
    { "<leader>sd", "<Cmd>FzfLua diagnostics_document<CR>",   desc = "Diagnostics document" },
    { "<leader>sk", "<Cmd>FzfLua keymaps<CR>",                desc = "Search keymaps" },

  },
  config = function()
    local fzf = require("fzf-lua")
    local actions = fzf.actions

    fzf.setup({
      "telescope",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      files = {
        formatter = "path.dirname_first",
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        }
      },
      buffers = {
        formatter = "path.dirname_first",
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      git = {
        files = {
          formatter = "path.dirname_first",
        }
      },
    })
  end
}
