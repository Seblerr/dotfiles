Config.now_if_args(function()
  -- codediff
  vim.pack.add({
    'https://github.com/esmuellert/codediff.nvim',
  })
  require('codediff').setup({})

  local function main_branch()
    local result = vim.system({ 'git', 'rev-parse', '--verify', '--quiet', 'origin/main' }):wait()
    return result.code == 0 and 'main' or 'master'
  end

  vim.keymap.set({ 'n', 'x' }, '<leader>gs', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff git status' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>CodeDiff file HEAD<cr>', { desc = 'CodeDiff file diff vs HEAD' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gm', function()
    vim.cmd('CodeDiff file ' .. main_branch())
  end, { desc = 'CodeDiff file diff vs main' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gb', function()
    vim.cmd('CodeDiff ' .. main_branch() .. '...')
  end, { desc = 'CodeDiff branch changes vs main' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gh', function()
    vim.cmd('CodeDiff history origin/' .. main_branch() .. '..HEAD')
  end, { desc = 'CodeDiff branch history vs main' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gH', '<cmd>CodeDiff history %<cr>', { desc = 'CodeDiff file history' })
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
