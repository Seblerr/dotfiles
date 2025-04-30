return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = "OXY2DEV/markview.nvim",
    version = false,
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'lua',
        'python',
        'vimdoc',
        'vim',
        'markdown',
        'markdown_inline',
        'xml',
        'rust',
        'json',
        'html',
        'javascript',
        'typescript',
        'svelte',
        'css',
        'regex'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
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
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
}
