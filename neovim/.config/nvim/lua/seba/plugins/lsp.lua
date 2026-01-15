local on_attach = function(client, bufnr)
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
        bashls = {},
        ruff = {},
        lemminx = {},
        tailwindcss = {},
        svelte = {},
        html = {},
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!reference sequence"
              }
            }
          }
        },
        hls = {},
        copilot = {},
        ty = {},
      }
    },
    config = function(_, opts)
      -- vim.lsp.inline_completion.enable()
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
    'p00f/clangd_extensions.nvim',
    ft = { "c", "cpp" },
    opts = {}
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
}
