return
{
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require('lspconfig')

      -- Get keybinds for LSP
      local lsp_settings = require('seba.lsp.attach')

      lspconfig.clangd.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--header-insertion-decorators=false"
        },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git")
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

      lspconfig.bashls.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
      })


      lspconfig.basedpyright.setup({
        settings = {
          basedpyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach
      })

      lspconfig.ruff.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach
      })

      lspconfig.lemminx.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach
      })

      -- Diagnostics icons
      for name, icon in pairs(require("seba.util.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
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
    "p00f/clangd_extensions.nvim",
    ft = {
      "c",
      "cpp",
    },
    config = function()
      local group = vim.api.nvim_create_augroup("clangd_extensions", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        desc = "Clangd specific keymaps",
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "clangd" then
            require("clangd_extensions").setup()
            vim.keymap.set(
              "n",
              "<leader>ss",
              "<cmd>ClangdSwitchSourceHeader<CR>",
              { buffer = bufnr, desc = "Switch between source and header" })
          end
        end,
      })
    end,
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
