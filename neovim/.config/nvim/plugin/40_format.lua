Config.later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

  require("conform").setup({
    formatters_by_ft = {
      cpp = { "clang_format" },
      json = { "jq" },
      sh = { "shfmt" },
      python = { "ruff_format" },
      nix = { "nixfmt" },
      yaml = { "yamlfmt" },
      css = { "prettier" }
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
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  })

  vim.api.nvim_create_user_command("FormatToggle", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    if vim.g.disable_autoformat then
      vim.notify("Disabled autoformat", vim.log.levels.WARN)
    else
      vim.notify("Enabled autoformat", vim.log.levels.INFO)
    end
  end, {
    desc = "Toggle autoformat-on-save",
    bang = true,
  })

  vim.keymap.set("n", "<leader>tf", "<Cmd>FormatToggle<CR>", { desc = "Toggle Autoformat" })
  vim.keymap.set("", "<leader>fo", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "Format buffer" })

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end)
