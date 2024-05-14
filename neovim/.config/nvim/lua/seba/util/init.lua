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

function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return M.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), "info", "Option")
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      return M.notify("Enabled " .. option, "info", "Option")
    else
      return M.notify("Disabled " .. option, "warn", "Option")
    end
  end
end

local diag_enabled = true
function M.toggle_diagnostics()
  diag_enabled = not diag_enabled
  if diag_enabled then
    vim.diagnostic.enable()
    M.notify("Enabled diagnostics", "info", "Diagnostics")
  else
    vim.diagnostic.disable()
    M.notify("Disabled diagnostics", "warn", "Diagnostics")
  end
end

local inlay_enabled = true
function M.toggle_inlay_hints()
  inlay_enabled = not inlay_enabled
  if inlay_enabled then
    vim.lsp.inlay_hint.enable(0, true)
    M.notify("Enabled inlay hints", "info", "LSP")
  else
    vim.lsp.inlay_hint.enable(0, false)
    M.notify("Disabled inlay hints", "warn", "LSP")
  end
end

function M.notify(message, level, title)
  local notify = require("notify")
  notify(message, level, { title = title })
end

return M
