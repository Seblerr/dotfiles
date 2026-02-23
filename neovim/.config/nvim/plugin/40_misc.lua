Config.later(function()
  -- tmux.nvim
  vim.pack.add({ 'https://github.com/nathom/tmux.nvim' })

  -- render-markdown
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
  require('render-markdown').setup({})

  -- codediff
  vim.pack.add({
    'https://github.com/seblerr/codediff.nvim',
  })
  require('codediff').setup({})
  vim.keymap.set({ 'n', 'x' }, '<leader>gs', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff git status' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>CodeDiff file HEAD<cr>', { desc = 'CodeDiff git diff' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gm', '<cmd>CodeDiff file master<cr>',
    { desc = 'CodeDiff git diff against master' })
end)
