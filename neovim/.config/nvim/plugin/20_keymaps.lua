-- [[ Keymaps ]]
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

-- Toggle
map("n", "<leader>ts", function() Config.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>tw", function() Config.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>tl", function()
  Config.toggle("relativenumber")
  Config.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>td", Config.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>ti", Config.toggle_inlay_hints, { desc = "Toggle Inlay Hints" })

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

-- [[ Autocmds ]]
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
vim.cmd([[autocmd FileType spec setlocal commentstring=#\ %s]])

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Open quickfix list automatically
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
  pattern = { "[^l]*" },
  command = "cwindow"
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "git",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dap-view",
    "dap-view-term",
    "dap-float",
    "grug-far"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Function to copy lines containing a pattern into a new buffer
function ExtractText(pattern)
  local original_buf = vim.api.nvim_get_current_buf()

  vim.cmd("tabnew")

  local new_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(new_buf, pattern)

  local lines = vim.api.nvim_buf_get_lines(original_buf, 0, -1, false)

  local matching_lines = {}
  for _, line in ipairs(lines) do
    if vim.fn.match(line, pattern) ~= -1 then
      table.insert(matching_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, matching_lines)
end

vim.api.nvim_create_user_command('Extract', function(opts)
  ExtractText(opts.args)
end, { nargs = 1 })

vim.api.nvim_set_keymap('n', '<leader>fi', ':lua ExtractText(vim.fn.input("Pattern: "))<CR>',
  { noremap = true, silent = true })
