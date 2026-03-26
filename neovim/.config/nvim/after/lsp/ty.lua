local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml' },
  capabilities = capabilities,
}
