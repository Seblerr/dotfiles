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
map('i', '<C-c>', '<Esc>')

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

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
map("n", "<leader>tf", "<Cmd>FormatToggle<CR>", { desc = "Toggle Autoformat" })

-- Toggle completion engine
vim.b.completion_engine = "codeium"
local function toggle_completion()
  if vim.b.completion_engine ~= "nvim-cmp" then
    require("cmp").setup.buffer({
      enabled = true,
      completion = {
        autocomplete = { "InsertEnter", "TextChanged" },
      }
    })
    require("neocodeium.commands").disable_buffer()
    vim.notify("Enabled nvim-cmp", vim.log.levels.INFO)
    vim.b.completion_engine = "nvim-cmp"
  else
    require("cmp").setup.buffer({ enabled = false })
    require("neocodeium.commands").enable_buffer()
    vim.notify("Enabled Codeium", vim.log.levels.INFO)
    vim.b.completion_engine = "codeium"
  end
end
map("n", "<leader>tc", function() toggle_completion() end, { desc = "Toggle completion engine in buffer" })

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
