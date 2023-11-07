local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'q:', '<nop>')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<leader>cn', ':cn<CR>')
map('n', '<leader>cp', ':cp<CR>')
map('i', '<C-c>', '<Esc>')
map('n', '<C-c>', '<Esc>')
map('n', '<leader>dh', ':diffget //2<CR>')
map('n', '<leader>dl', ':diffget //3<CR>')
map('n', '<leader>do', ':only<CR>')

-- TMUX
map('n', '<C-h>', [[<cmd>lua require('tmux').move_left()<cr>]], { silent = true })
map('n', '<C-l>', [[<cmd>lua require('tmux').move_right()<cr>]], { silent = true })
map('n', '<C-k>', [[<cmd>lua require('tmux').move_up()<cr>]], { silent = true })
map('n', '<C-j>', [[<cmd>lua require('tmux').move_down()<cr>]], { silent = true })
