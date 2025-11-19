return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    enabled = function()
      return not vim.list_contains({ 'DressingInput' }, vim.bo.filetype)
          and vim.bo.buftype ~= 'prompt'
          and vim.b.completion ~= false
    end,
    cmdline = {
      enabled = false
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
