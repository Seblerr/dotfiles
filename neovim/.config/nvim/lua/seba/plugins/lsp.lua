return
{
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = "Mason",
        dependencies = {
          'williamboman/mason.nvim',
        },
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup {
            ensure_installed = {
              "lua_ls",
              "bashls",
              "pyright",
            } }
        end
      },
      { 'hrsh7th/cmp-nvim-lsp', },
      { 'j-hui/fidget.nvim',    tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim',    opts = {} },
    },
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

      lspconfig.bashls.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
      })

      lspconfig.pyright.setup({
        capabilities = lsp_settings.capabilities,
        on_attach = lsp_settings.on_attach,
      })

      -- Diagnostics icons
      for name, icon in pairs(require("seba.util.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end
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

      vim.api.nvim_create_autocmd("Filetype", {
        group = group,
        desc = "Setup clangd_extension scores for cmp",
        pattern = "c,cpp",
        callback = function()
          local cmp = require "cmp"
          cmp.setup.buffer {
            sorting = {
              comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                require "clangd_extensions.cmp_scores",
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
              },
            },
          }
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        desc = "Clangd specific keymaps",
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "clangd" then
            require("clangd_extensions").setup()
            -- require("clangd_extensions.inlay_hints").setup_autocmd()
            if vim.fn.has("nvim-0.10") == 1 then
              vim.lsp.inlay_hint.enable(0, false)
            end
            vim.keymap.set(
              "n",
              "<leader>ss",
              "<cmd>ClangdSwitchSourceHeader<CR>",
              { buffer = bufnr, desc = "Switch between source and header" })
            -- vim.keymap.set(
            --   "n",
            --   "<leader>ui",
            --   function()
            --     if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
            --       require("clangd_extensions.inlay_hints").disable_inlay_hints()
            --     else
            --       require("clangd_extensions.inlay_hints").set_inlay_hints()
            --     end
            --   end,
            --   { buffer = bufnr, desc = "Switch between source and header" })
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
