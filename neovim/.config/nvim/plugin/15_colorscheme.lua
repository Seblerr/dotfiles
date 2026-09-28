-- Config.now(function()
--   vim.cmd.colorscheme('miniautumn')
-- end)

Config.now(function()
  vim.pack.add({ { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } })
  require("catppuccin").setup({
    flavour = "mocha",
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
  })
  vim.cmd.colorscheme('catppuccin')
end)

-- tmux does not answer the OSC 11 query in this setup, so sync through
-- passthrough without querying the terminal's original background color.
Config.later(function()
  local has_stdout_tty = false
  for _, ui in ipairs(vim.api.nvim_list_uis()) do
    has_stdout_tty = has_stdout_tty or ui.stdout_tty
  end
  if not has_stdout_tty then return end

  local send = function(sequence)
    io.stdout:write('\27Ptmux;' .. sequence:gsub('\27', '\27\27') .. '\27\\')
    io.stdout:flush()
  end

  local sync = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
    if normal.bg ~= nil then send(('\27]11;#%06x\7'):format(normal.bg)) end
  end

  sync()
  vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimResume' }, { callback = sync })
  vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, {
    callback = function() send('\27]111\27\\') end,
  })
end)
