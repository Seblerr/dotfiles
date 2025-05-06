return
{
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        "SmiteshP/nvim-navic",
        opts = {
          highlight = true,
          depth_limit = 5,
          lazy_update_context = true,
        }
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--header-insertion=never",
            "--header-insertion-decorators=false",
          },
        },
        lua_ls = {
          Lua = {
            settings = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            }
          },
        },
        bashls = {},
        basedpyright = {
          settings = {
            basedpyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
              },
            },
          }
        },
        ruff = {},
        lemminx = {},
        ts_ls = {},
        tailwindcss = {},
        svelte = {},
        html = {},
        yamlls = {},
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')

      -- Get keybinds for LSP
      local lsp_settings = require('seba.lsp.attach')

      for server, config in pairs(opts.servers or {}) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        config.on_attach = lsp_settings.on_attach
        lspconfig[server].setup(config)
      end


      vim.diagnostic.config({
        virtual_text = {
          severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
          },
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

          },
        }
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Clangd specific keymaps",
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "clangd" then
            vim.keymap.set(
              "n",
              "<leader><Tab>",
              "<cmd>ClangdSwitchSourceHeader<CR>",
              { buffer = bufnr, desc = "Switch between source and header" })
          end
        end,
      })
    end
  },

  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup {
          ensure_installed = {
            "lua_ls",
            "bashls",
            "basedpyright",
          } }
      end
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
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
