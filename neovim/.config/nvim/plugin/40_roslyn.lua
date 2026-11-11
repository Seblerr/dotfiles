Config.on_filetype('cs', function()
  vim.pack.add({ 'https://github.com/seblyng/roslyn.nvim' })

  vim.env.DOTNET_ROOT = vim.env.DOTNET_ROOT or vim.fn.expand('~/.dotnet')
  vim.env.EnableWindowsTargeting = vim.env.EnableWindowsTargeting or 'true'
  vim.env.NUGET_PACKAGES = vim.env.NUGET_PACKAGES or vim.fn.expand('~/.nuget/packages')

  vim.lsp.config('roslyn', {
    settings = {
      ['csharp|background_analysis'] = {
        dotnet_analyzer_diagnostics_scope = 'fullSolution',
        dotnet_compiler_diagnostics_scope = 'fullSolution',
      },
    },
  })

  require('roslyn').setup({
    choose_target = function(targets)
      local slns = vim.iter(targets):filter(function(t) return t:match('%.sln$') end):totable()
      if #slns == 1 then return slns[1] end
    end,
  })
end)
