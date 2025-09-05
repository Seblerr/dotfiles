return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
