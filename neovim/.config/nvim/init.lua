-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugin manager: vim.pack (built-in)
_G.Config = {}

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

-- Loading helpers via MiniMisc.safely()
local misc = require('mini.misc')
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

-- Autocommand helper
local gr = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- vim.pack hook helper
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback()
  end
  Config.new_autocmd('PackChanged', '*', f, desc)
end

-- Utility functions
Config.get_git_root = function()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

Config.toggle = function(option, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if vim.opt_local[option]:get() then
    vim.notify("Enabled " .. option, vim.log.levels.INFO)
  else
    vim.notify("Disabled " .. option, vim.log.levels.WARN)
  end
end

Config.toggle_diagnostics = function()
  if vim.b.diag_enabled == nil then
    vim.b.diag_enabled = true
  end
  vim.diagnostic.enable(not vim.b.diag_enabled, { bufnr = 0 })
  vim.b.diag_enabled = not vim.b.diag_enabled
  vim.notify("Diagnostics: " .. (vim.b.diag_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

Config.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  vim.notify("Inlay hints: " .. (vim.lsp.inlay_hint.is_enabled({}) and "enabled" or "disabled"), vim.log.levels.INFO)
end
