return {

  -- add rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "rust")
    end,
  },

  -- correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "K", "<cmd>RustHoverActions<CR>", { buffer = buffer, desc = "Hover Actions (Rust)" })
          vim.keymap.set("n", "<Leader>a", "<cmd>RustCodeAction<CR>", { buffer = buffer, desc = "Code Action (Rust)" })
        end)
      end,
    },
    opts = {
      servers = {
        rust_analyzer = {
          mason = false,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              -- Add clippy lints for Rust.
              checkOnSave = true,
              check = {
                command = "clippy",
                features = "all",
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local rust_opts = {
            server = vim.tbl_deep_extend("force", {}, opts, opts.server or {}),
            tools = {
              hover_actions = {
                auto_focus = false,
                border = "none",
              },
              -- inlay_hints = {
              --   auto = true,
              --   show_parameter_hints = true,
              -- },
            },
          }
          require("rust-tools").setup(rust_opts)
          return true
        end,
      },
    },
  },
}
