return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>,",  "<Cmd>FzfLua buffers<CR>", desc = "FzfLua buffers" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",    desc = "FzfLua grep" },
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
    { "<leader>sw", "<Cmd>FzfLua grep_cword<CR>",  mode = { "n" }, desc = "FzfLua current word" },
    { "<leader>sw", "<Cmd>FzfLua grep_visual<CR>", mode = { "x" }, desc = "FzfLua grep visual selection" },

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
        formatter = "path.filename_first",
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
