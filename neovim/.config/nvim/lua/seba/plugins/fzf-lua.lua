return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>ff", "<Cmd>FzfLua files<CR>",                    desc = "FzfLua files" },
    {
      "<leader>fF",
      function()
        local git_root = require('seba.util').get_git_root()
        require('fzf-lua').files({ cwd = git_root })
      end,
      desc = "FzfLua files (git root)"
    },
    { "<leader>,",  "<Cmd>FzfLua buffers<CR>",                  desc = "FzfLua buffers" },
    { "<leader>fp", "<Cmd>FzfLua files cwd=~/.config/nvim<CR>", desc = "FzfLua files" },
    { "<leader>fg", "<Cmd>FzfLua git_files<CR>",                desc = "FzfLua git files" },
    { "<leader>gl", "<Cmd>FzfLua git_bcommits<CR>",             desc = "FzfLua git log (buffer)" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",                     desc = "FzfLua grep" },
    { "<leader>sf", "<Cmd>FzfLua live_grep<CR>",                desc = "FzfLua live grep (fuzzy)" },
    { "<leader>sc", "<Cmd>FzfLua grep_curbuf<CR>",              desc = "FzfLua fuzzy grep current buffer" },
    { "<leader>/",  "<Cmd>FzfLua lgrep_curbuf<CR>",             desc = "FzfLua grep current buffer" },
    { "<leader>sw", "<Cmd>FzfLua grep_cword<CR>",               desc = "FzfLua current word" },
    { "<leader>sr", "<Cmd>FzfLua resume<CR>",                   desc = "FzfLua resume" },
    { "<leader>sd", "<Cmd>FzfLua diagnostics_document<CR>",     desc = "Diagnostics document" },
    { "<leader>sk", "<Cmd>FzfLua keymaps<CR>",                  desc = "Search keymaps" },

  },
  config = function()
    require("fzf-lua").setup({ 'telescope' })
  end
}
