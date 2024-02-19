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
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("config").diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("config").diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("config").diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("config").diagnostics.Info,
          },
        },
      },
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
          "--header-insertion-decorators=false",
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

      lspconfig.pyright.setup({})

      -- Diagnostics icons
      for name, icon in pairs(require("config").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
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
