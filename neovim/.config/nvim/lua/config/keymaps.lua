-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<leader>cn', ':cn<CR>')
map('n', '<leader>cp', ':cp<CR>')
map('i', '<C-c>', '<Esc>')

-- TMUX
map('n', '<C-h>', [[<cmd>lua require('tmux').move_left()<cr>]], {silent = true})
map('n', '<C-l>', [[<cmd>lua require('tmux').move_right()<cr>]], {silent = true})
map('n', '<C-k>', [[<cmd>lua require('tmux').move_up()<cr>]], {silent = true})
map('n', '<C-j>', [[<cmd>lua require('tmux').move_down()<cr>]], {silent = true})
