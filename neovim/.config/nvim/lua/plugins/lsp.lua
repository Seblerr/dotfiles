return
{
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'williamboman/mason.nvim',
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = { ensure_installed = { "lua_ls" } },
        config = function(_, opts)
          require("mason").setup(opts)
        end
      },
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    opts = {
      autoformat = true,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- Get keybinds for LSP
      require('lsp.attach')

      require('neodev').setup()


      lspconfig.clangd.setup({
        capabilities = require('lsp.attach').capabilities,
        on_attach = require('lsp.attach').on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed"
        }
      })

      lspconfig["lua_ls"].setup({
        capabilities = require('lsp.attach').capabilities,
        on_attach = require('lsp.attach').on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          }
        }
      })
    end
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require('lsp.attach').on_attach(client, bufnr)
          end,
          capabilities = require('lsp.attach').capabilities,
        },
      }
    end,
  },
}
