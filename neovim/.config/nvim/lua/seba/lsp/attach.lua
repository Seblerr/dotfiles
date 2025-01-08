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

  nmap('gd', "<cmd>FzfLua lsp_definitions<cr>", 'Lsp definitions')
  nmap('gD', "<cmd>FzfLua lsp_document_symbols<cr>", 'Lsp document symbols')
  nmap('gR', "<cmd>FzfLua lsp_finder<cr>", 'Lsp Finder')
  nmap('gr', "<cmd>FzfLua lsp_references<cr>", 'Lsp references')
  nmap('gI', "<cmd>FzfLua lsp_implementations<cr>", 'Lsp implementations')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Lsp type definitions')
  nmap("<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", 'diagnostic open float')
  nmap("<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", 'Diagnostics quick-fix')
  nmap('<leader>ds', "<cmd>FzfLua lsp_document_symbols<cr>", 'Lsp document symbols')
  nmap('<leader>ws', "<cmd>FzfLua lsp_workspace_symbols<cr>", 'Lsp workspace symbols')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
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
