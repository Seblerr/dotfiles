return
{
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        'L3MON4D3/LuaSnip',
        version = "v2.*"
      },
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          'hrsh7th/nvim-cmp',
          'hrsh7th/cmp-nvim-lsp',
        }
      },
      'rafamadriz/friendly-snippets',
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'path' },
          { name = 'buffer',  keyword_length = 3 }
        },
        formatting = {
          format = function(entry, item)
            local ELLIPSIS_CHAR = '…'
            local MAX_LABEL_WIDTH = 20
            local MIN_LABEL_WIDTH = 20

            local label = item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
              item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
              local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
              item.abbr = label .. padding
            end

            local icons = require("seba.util.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            item.menu = ""

            return item
          end,
        },
      }
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
    end
  },
}
