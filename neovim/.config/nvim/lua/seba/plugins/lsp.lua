local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
  if client.name == 'ruff' then
    client.server_capabilities.hoverProvider = false
  end
end

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
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            }
          },
        },
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
        bashls = {},
        ruff = {},
        lemminx = {},
        tailwindcss = {},
        svelte = {},
        html = {},
        yamlls = {},
        hls = {}
      }
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers or {}) do
        config.on_attach = on_attach

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

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
              { buffer = bufnr, desc = "Switch between source and header" }
            )
          end
        end,
      })
    end
  },


  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    opts = {}
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
          end,
        },
      }
    end,
  },
}
