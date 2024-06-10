local M = {}

M.root_patterns = { ".git", "lua", "compile_commands.json" }

M.get_git_root = function()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

-- Check if plugin installed
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.toggle(option, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if vim.opt_local[option]:get() then
    vim.notify("Enabled " .. option, vim.log.levels.INFO)
  else
    vim.notify("Disabled " .. option, vim.log.levels.WARN)
  end
end

local diag_enabled = true
function M.toggle_diagnostics()
  diag_enabled = not diag_enabled
  if diag_enabled then
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics", vim.log.levels.INFO)
  else
    vim.diagnostic.enable(false)
    vim.notify("Disabled diagnostics", vim.log.levels.WARN)
  end
end

function M.toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end

return M
