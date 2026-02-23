local util = require("seba.util")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<leader>cn', ':cn<CR>')
map('n', '<leader>cp', ':cp<CR>')

map('n', '<leader>ba', '<Cmd>b#<CR>', { desc = 'Alternate buffer' })

vim.keymap.del({ 'n', 'x' }, 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grt')
vim.keymap.del('n', 'gri')

map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })

-- Yank current path
vim.keymap.set('n', '<leader>yp', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Yank file path' })

-- Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = 'Diagnostic open float' })
map("n", "<leader>Q", vim.diagnostic.setloclist, { desc = 'Diagnostics quick-fix' })

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
map({ "n" }, "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear hlsearch" })

map("n", "gw", "*N")
map("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Toggle
map("n", "<leader>ts", function() util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>tw", function() util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>tl", function()
  util.toggle("relativenumber")
  util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>td", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>ti", util.toggle_inlay_hints, { desc = "Toggle Inlay Hints" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- TMUX
map('n', '<C-h>', [[<cmd>lua require('tmux').move_left()<cr>]], { silent = true })
map('n', '<C-l>', [[<cmd>lua require('tmux').move_right()<cr>]], { silent = true })
map('n', '<C-k>', [[<cmd>lua require('tmux').move_up()<cr>]], { silent = true })
map('n', '<C-j>', [[<cmd>lua require('tmux').move_down()<cr>]], { silent = true })
