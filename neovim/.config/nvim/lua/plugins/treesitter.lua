return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { 'lua', 'c', 'cpp', 'python', 'help', "markdown_inline", "html", "regex", "yaml" },
    },
    -- config = function()
    --   require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
    -- end,
  }
}
