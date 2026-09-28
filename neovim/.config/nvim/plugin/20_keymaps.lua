-- [[ Keymaps ]]
local map = vim.keymap.set

-- Leader group descriptions (used by mini.clue in 30_mini.lua)
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>a', desc = '+AI' },
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>c', desc = '+Code' },
  { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
  { mode = 'n', keys = '<Leader>e', desc = '+Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
  { mode = 'n', keys = '<Leader>w', desc = '+Window' },
  { mode = 'n', keys = '<Leader>y', desc = '+Yank' },
  { mode = 'x', keys = '<Leader>a', desc = '+AI' },
  { mode = 'x', keys = '<Leader>f', desc = '+Find' },
  { mode = 'x', keys = '<Leader>g', desc = '+Git' },
}

map({ 'n', 'v' }, '<Space>', '<Nop>')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<leader>cn', ':cn<CR>', { desc = 'Next quickfix' })
map('n', '<leader>cp', ':cp<CR>', { desc = 'Previous quickfix' })
map('n', '<leader>ba', '<Cmd>b#<CR>', { desc = 'Alternate buffer' })

map('n', '<leader>ec', function()
  require('mini.pick').builtin.files(nil, { source = { cwd = vim.fn.stdpath('config') } })
end, { desc = 'Config files' })
map('n', '<leader>ef', function()
  local mf = require('mini.files')
  if not mf.close() then
    local name = vim.api.nvim_buf_get_name(0)
    mf.open(name ~= '' and name or nil)
  end
end, { desc = 'MiniFiles open (current file)' })
map('n', '<leader>ed', function()
  local mf = require('mini.files')
  if not mf.close() then mf.open() end
end, { desc = 'MiniFiles open (working directory)' })

-- MiniPick mappings.
map('n', '<leader>f/', '<Cmd>Pick history scope="/"<CR>', { desc = 'Search history' })
map('n', '<leader>f:', '<Cmd>Pick history scope=":"<CR>', { desc = 'Command history' })
map('n', '<leader>fa', '<Cmd>Pick git_hunks scope="staged"<CR>', { desc = 'Added hunks' })
map('n', '<leader>fA', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', { desc = 'Added hunks (buffer)' })
map('n', '<leader>,', '<Cmd>Pick buffers<CR>', { desc = 'Buffers' })
map('n', '<leader>fc', '<Cmd>Pick git_commits<CR>', { desc = 'Commits' })
map('n', '<leader>fC', '<Cmd>Pick git_commits path="%"<CR>', { desc = 'Commits (buffer)' })
map('n', '<leader>fd', '<Cmd>Pick diagnostic scope="current"<CR>', { desc = 'Diagnostics (buffer)' })
map('n', '<leader>fD', '<Cmd>Pick diagnostic scope="all"<CR>', { desc = 'Diagnostics (workspace)' })
map('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Files' })
map('n', '<leader>fF', '<Cmd>Pick git_files<CR>', { desc = 'Git files' })
map('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Live grep' })
map('n', '<leader>fG', '<Cmd>Pick grep<CR>', { desc = 'Grep pattern' })
map('n', '<leader>fw', '<Cmd>Pick grep pattern="<cword>"<CR>', { desc = 'Grep word under cursor' })
map('x', '<leader>fw', function()
  local lines = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
  if #lines ~= 1 then return end
  MiniPick.builtin.grep({ pattern = lines[1], method = 'plain' })
end, { desc = 'Grep selection' })
map('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Help tags' })
map('n', '<leader>fH', '<Cmd>Pick hl_groups<CR>', { desc = 'Highlight groups' })
map('n', '<leader>fk', '<Cmd>Pick keymaps<CR>', { desc = 'Keymaps' })
map('n', '<leader>fl', '<Cmd>Pick buf_lines scope="current"<CR>', { desc = 'Lines (buffer)' })
map('n', '<leader>fL', '<Cmd>Pick buf_lines scope="all"<CR>', { desc = 'Lines (all)' })
map('n', '<leader>fm', '<Cmd>Pick git_hunks<CR>', { desc = 'Modified hunks' })
map('n', '<leader>fM', '<Cmd>Pick git_hunks path="%"<CR>', { desc = 'Modified hunks (buffer)' })
map('n', '<leader>fr', '<Cmd>Pick resume<CR>', { desc = 'Resume picker' })
map('n', '<leader>fR', '<Cmd>Pick lsp scope="references"<CR>', { desc = 'References (LSP)' })
map('n', '<leader>fs', '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>', { desc = 'Symbols (workspace)' })
map('n', '<leader>fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', { desc = 'Symbols (document)' })
map('n', '<leader>fv', '<Cmd>Pick visit_paths cwd=""<CR>', { desc = 'Visited paths (all)' })
map('n', '<leader>fV', '<Cmd>Pick visit_paths<CR>', { desc = 'Visited paths (cwd)' })

map('n', 'gr', '<Cmd>Pick lsp scope="references"<CR>', { desc = 'References' })
map('n', 'gd', '<Cmd>Pick lsp scope="definition"<CR>', { desc = 'Definition' })
map('n', 'gD', '<Cmd>Pick lsp scope="declaration"<CR>', { desc = 'Declaration' })
map('n', 'gi', '<Cmd>Pick lsp scope="implementation"<CR>', { desc = 'Implementation' })
map('n', '<leader>D', '<Cmd>Pick lsp scope="type_definition"<CR>', { desc = 'Type definition' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

vim.keymap.del({ 'n', 'x' }, 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grt')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grx')
map('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'Run code lens' })

-- Yank current path
map('n', '<leader>yp', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Yank file path' })
map('n', '<leader>yb', function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
end, { desc = 'Yank file name' })

-- Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic location list' })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = 'Diagnostic open float' })

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
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Builtin undotree
vim.keymap.set("n", "<leader>u", require("undotree").open)

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

-- incremental selection treesitter/lsp
vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })


-- [[ Autocmds ]]
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

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

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "nvim-pack",
    "nvim-undotree",
    "help",
    "git",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "startuptime",
    "checkhealth",
    "dap-view",
    "dap-view-term",
    "dap-float",
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
