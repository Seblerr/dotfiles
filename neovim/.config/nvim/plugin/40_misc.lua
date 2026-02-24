Config.now_if_args(function()
  -- codediff
  vim.pack.add({
    'https://github.com/esmuellert/codediff.nvim',
  })
  require('codediff').setup({})
  vim.keymap.set({ 'n', 'x' }, '<leader>gs', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff git status' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>CodeDiff file HEAD<cr>', { desc = 'CodeDiff git diff' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gm', '<cmd>CodeDiff file master<cr>',
    { desc = 'CodeDiff git diff against master' })
end)

Config.later(function()
  -- tmux.nvim
  vim.pack.add({ 'https://github.com/nathom/tmux.nvim' })
  local tmux = require('tmux')
  vim.keymap.set('n', '<C-h>', tmux.move_left, { silent = true })
  vim.keymap.set('n', '<C-l>', tmux.move_right, { silent = true })
  vim.keymap.set('n', '<C-k>', tmux.move_up, { silent = true })
  vim.keymap.set('n', '<C-j>', tmux.move_down, { silent = true })

  -- render-markdown
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
  require('render-markdown').setup({})
end)
