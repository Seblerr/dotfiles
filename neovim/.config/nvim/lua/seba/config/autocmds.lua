vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
vim.cmd([[autocmd FileType spec setlocal commentstring=#\ %s]])

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Open quickfix list automatically
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
  pattern = { "[^l]*" },
  command = "cwindow"
})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})


-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "git",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dap-view",
    "dap-view-term",
    "dap-float"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Function to copy lines containing a pattern into a new buffer
function ExtractText(pattern)
  local original_buf = vim.api.nvim_get_current_buf()

  vim.cmd("tabnew")

  local new_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(new_buf, pattern)

  local lines = vim.api.nvim_buf_get_lines(original_buf, 0, -1, false)

  local matching_lines = {}
  for _, line in ipairs(lines) do
    if vim.fn.match(line, pattern) ~= -1 then
      table.insert(matching_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, matching_lines)
end

vim.api.nvim_create_user_command('Extract', function(opts)
  ExtractText(opts.args)
end, { nargs = 1 })

vim.api.nvim_set_keymap('n', '<leader>fi', ':lua ExtractText(vim.fn.input("Pattern: "))<CR>',
  { noremap = true, silent = true })
