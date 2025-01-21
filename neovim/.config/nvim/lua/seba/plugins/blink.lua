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
    keymap = {
      preset = 'default',
      cmdline = {
        ["<Tab>"] = {}
      }
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
    }
  },
  opts_extend = { "sources.default" }
}
