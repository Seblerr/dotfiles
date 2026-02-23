-- [[ Setting options ]]
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.termguicolors = true
opt.scrolloff = 8
opt.swapfile = false
opt.list = true
opt.listchars:append({ tab = '▸ ' })
opt.listchars:append({ trail = '·' })
opt.autowrite = true           -- Enable auto write
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.foldlevel = 99
opt.laststatus = 3
opt.pumblend = 10     -- Popup blend
opt.pumheight = 10    -- Maximum number of entries in a popup
opt.shiftround = true -- Round indent
opt.shiftwidth = 2    -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false  -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.numberwidth = 3
opt.signcolumn = "yes:2"
opt.statuscolumn = "%l%s"
opt.smartcase = true   -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true  -- Put new windows below current
opt.splitright = true  -- Put new windows right of current
opt.tabstop = 2        -- Number of spaces tabs count for
opt.updatetime = 250
opt.timeoutlen = 1000
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap
opt.winborder = "rounded"
opt.exrc = true
opt.secure = true
vim.schedule(function()
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
end)

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Disable provider warnings
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- [[ Diagnostics ]]
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    }
  }
})
