Config.now_if_args(function()
  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  Config.on_packchanged('nvim-treesitter', { 'install', 'update' }, function()
    vim.cmd('TSUpdate')
  end, 'Run :TSUpdate after nvim-treesitter changes')

  require('nvim-treesitter.install').compilers = { "clang", "gcc" }
  require("nvim-treesitter.configs").setup({
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
      'regex',
      'yaml',
      'haskell'
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
  })

  vim.pack.add({ 'https://github.com/windwp/nvim-ts-autotag' })
  require('nvim-ts-autotag').setup()
end)
