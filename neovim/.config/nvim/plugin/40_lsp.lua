Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  local servers = {
    'clangd',
    'lua_ls',
    'bashls',
    'ruff',
    'lemminx',
    'tailwindcss',
    'svelte',
    'html',
    'yamlls',
    'hls',
    'copilot',
    'ty',
  }

  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, desc = 'Rename' })

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Clangd specific keymaps",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client ~= nil and client.name == "clangd" then
        vim.keymap.set(
          "n",
          "<leader><Tab>",
          "<cmd>ClangdSwitchSourceHeader<CR>",
          { buffer = args.buf, desc = "Switch between source and header" }
        )
      end
    end,
  })
end)

Config.on_filetype('c,cpp', function()
  vim.pack.add({ 'https://github.com/p00f/clangd_extensions.nvim' })
  require('clangd_extensions').setup({})
end)

Config.on_filetype('lua', function()
  vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })
  require('lazydev').setup({})
end)

Config.later(function()
  vim.pack.add({ 'https://github.com/williamboman/mason.nvim' })
  require('mason').setup({})
end)
