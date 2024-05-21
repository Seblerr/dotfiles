return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { 'bash', 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim', 'markdown', 'xml', 'rust' },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').compilers = { "clang", "gcc" }
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
}
