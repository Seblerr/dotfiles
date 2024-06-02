return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  dependencies = "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>fo",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang_format" },
        sh = { "shfmt" },
        python = { "ruff_format" }
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" }
        }
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    })

    vim.api.nvim_create_user_command("FormatToggle", function()
      local util = require("seba.util")
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        util.notify("Autoformat disabled", "warn", "conform.nvim")
      else
        util.notify("Autoformat enabled", "info", "conform.nvim")
      end
    end, {
      desc = "Toggle autoformat-on-save",
      bang = true,
    })
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
