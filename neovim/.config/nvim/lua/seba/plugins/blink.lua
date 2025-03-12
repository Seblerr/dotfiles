return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
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
  },
  opts_extend = { "sources.default" }
}
