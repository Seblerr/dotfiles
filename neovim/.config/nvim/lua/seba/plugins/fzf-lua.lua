return
{
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      preview = {
        hidden = 'hidden'
      },
    },
  },
  keys = {
    { "<leader>fb", "<Cmd>FzfLua buffers<CR>",                  desc = "FzfLua buffers" },
    { "<leader>,",  "<Cmd>FzfLua buffers<CR>",                  desc = "FzfLua buffers" },
    { "<leader>ff", "<Cmd>FzfLua files<CR>",                    desc = "FzfLua files" },
    { "<leader>fp", "<Cmd>FzfLua files cwd=~/.config/nvim<CR>", desc = "FzfLua files" },
    { "<leader>fg", "<Cmd>FzfLua git_files<CR>",                desc = "FzfLua git files" },
    { "<leader>sg", "<Cmd>FzfLua grep<CR>",                     desc = "FzfLua grep" },
    { "<leader>sf", "<Cmd>FzfLua live_grep<CR>",                desc = "FzfLua live grep (fuzzy)" },
    { "<leader>/",  "<Cmd>FzfLua lgrep_curbuf<CR>",             desc = "FzfLua fuzzy grep current buffer" },
    { "<leader>sw", "<Cmd>FzfLua grep_cword<CR>",               desc = "FzfLua current word" },
    { "<leader>sr", "<Cmd>FzfLua resume<CR>",                   desc = "FzfLua resume" },
    { "<leader>sd", "<Cmd>FzfLua diagnostics_document<CR>",     desc = "Diagnostics document" },
    { "<leader>sk", "<Cmd>FzfLua keymaps<CR>",                  desc = "Search keymaps" },

  },
  config = function(_, opts)
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({ 'telescope', opts })
  end
}
