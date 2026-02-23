Config.now(function()
  vim.pack.add({ 'https://github.com/catppuccin/nvim', name = 'catppuccin' })
  require("catppuccin").setup({
    flavour = "mocha",
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
  })
  vim.cmd([[colorscheme catppuccin]])
end)
