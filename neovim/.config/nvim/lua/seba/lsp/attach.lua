local M = {}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local function lsp_keymaps(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code action')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Lsp type definitions')
  nmap("<leader>cd", vim.diagnostic.open_float, 'Diagnostic open float')
  nmap("<leader>Q", vim.diagnostic.setloclist, 'Diagnostics quick-fix')
end

M.on_attach = function(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover for ruff
    client.server_capabilities.hoverProvider = false
  end
  lsp_keymaps(bufnr)
end

M.capabilities = require('blink.cmp').get_lsp_capabilities()

return M
