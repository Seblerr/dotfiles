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
            [vim.diagnostic.severity.ERROR] = require("seba.util.icons").diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("seba.util.icons").diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("seba.util.icons").diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("seba.util.icons").diagnostics.Info,
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
      local lsp_settings = require('seba.lsp.attach')

      require('neodev').setup()


      lspconfig.clangd.setup({
        capabilities = lsp_settins.capabilities,
        on_attach = lsp_settins.on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--header-insertion-decorators=false"
        }
      })

      lspconfig["lua_ls"].setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          }
        }
      })

      lspconfig.pyright.setup({})

      -- Diagnostics icons
      for name, icon in pairs(require("seba.util.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end
  },

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require('seba.lsp.attach').on_attach(client, bufnr)
          end,
          capabilities = require('seba.lsp.attach').capabilities,
        },
      }
    end,
  },
}
