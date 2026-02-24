Config.now_if_args(function()
  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  Config.on_packchanged('nvim-treesitter', { 'install', 'update' }, function()
    vim.cmd('TSUpdate')
  end, 'Run :TSUpdate after nvim-treesitter changes')

  local languages = {
    'bash', 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim',
    'markdown', 'markdown_inline', 'xml', 'rust', 'json',
    'html', 'javascript', 'typescript', 'svelte', 'css',
    'regex', 'yaml', 'haskell',
  }

  -- Install missing parsers
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  Config.new_autocmd('FileType', filetypes, function(ev)
    vim.treesitter.start(ev.buf)
  end, 'Start tree-sitter')

  vim.pack.add({ 'https://github.com/windwp/nvim-ts-autotag' })
  require('nvim-ts-autotag').setup()
end)
