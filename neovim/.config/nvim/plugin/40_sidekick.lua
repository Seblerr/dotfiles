Config.later(function()
  vim.pack.add({ 'https://github.com/folke/sidekick.nvim' })

  require("sidekick").setup({
    nes = {
      enabled = false
    },
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  })

  vim.keymap.set('n', '<leader>aa', function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle CLI" })
  vim.keymap.set('n', '<leader>as', function() require("sidekick.cli").select({ filter = { installed = true } }) end, { desc = "Select CLI" })
  vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require("sidekick.cli").send({ msg = "{this}" }) end, { desc = "Send This" })
  vim.keymap.set('x', '<leader>av', function() require("sidekick.cli").send({ msg = "{selection}" }) end, { desc = "Send Visual Selection" })
  vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() require("sidekick.cli").prompt() end, { desc = "Sidekick Select Prompt" })
  vim.keymap.set({ 'n', 'x', 'i', 't' }, '<c-,>', function() require("sidekick.cli").focus() end, { desc = "Sidekick Switch Focus" })
  vim.keymap.set('n', '<leader>aq', function() require("sidekick.cli").toggle({ name = "amazon_q", focus = true }) end, { desc = "Sidekick Toggle Claude" })
end)
