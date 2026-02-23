vim.filetype.add({
  extension = { log = 'log', LOG = 'log' },
  pattern = { ['.*_log'] = 'log', ['.*_LOG'] = 'log' },
})
