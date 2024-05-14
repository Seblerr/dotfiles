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

  nmap('gd', "<cmd>FzfLua lsp_definitions<cr>", '[G]oto [D]efinition')
  nmap('gD', "<cmd>FzfLua lsp_document_symbols<cr>", '[G]oto [D]efinition')
  nmap('gr', "<cmd>FzfLua lsp_references<cr>", '[G]oto [R]eferences')
  nmap('gI', "<cmd>FzfLua lsp_implementations<cr>", '[G]oto [I]mplementation')
  nmap("gR", '<cmd>lua require("trouble").toggle("lsp_references")<CR>', 'Trouble LSP references')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap("<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", 'diagnostic open float')
  nmap("<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", 'Diagnostics quick-fix')
  nmap('<leader>ds', "<cmd>FzfLua lsp_document_symbols<cr>", '[D]ocument [S]ymbols')
  nmap('<leader>ws', "<cmd>FzfLua lsp_workspace_symbols<cr>", '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

M.on_attach = function(_, bufnr)
  lsp_keymaps(bufnr)
  if vim.fn.has("nvim-0.10") == 1 then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
