-- .NET development: Roslyn LSP, build/run/test, test runner and debugger (netcoredbg).
-- easy-dotnet owns the C# language server, so do NOT add roslyn.nvim or omnisharp in Mason:
-- two C# servers on the same buffer produce duplicate diagnostics and fighting code actions.
--
-- Requires: dotnet tool install -g EasyDotnet
-- Health:   :checkhealth easy-dotnet

local function dotnet(cmd)
  return function()
    vim.cmd('Dotnet ' .. cmd)
  end
end

return {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap' },
    ft = { 'cs', 'csproj', 'sln', 'slnx', 'props', 'razor' },
    cmd = 'Dotnet',
    keys = {
      { '<leader>nb', dotnet 'build solution quickfix', desc = '.[N]ET [B]uild solution (quickfix)' },
      { '<leader>nB', dotnet 'build quickfix', desc = '.[N]ET [B]uild project (quickfix)' },
      { '<leader>nt', dotnet 'testrunner', desc = '.[N]ET [T]est runner' },
      { '<leader>nT', dotnet 'test solution', desc = '.[N]ET [T]est solution' },
      { '<leader>nr', dotnet 'run', desc = '.[N]ET [R]un project' },
      { '<leader>nd', dotnet 'debug', desc = '.[N]ET [D]ebug project' },
      { '<leader>nw', dotnet 'watch', desc = '.[N]ET [W]atch' },
      { '<leader>nR', dotnet 'restore', desc = '.[N]ET [R]estore' },
      { '<leader>ne', dotnet 'diagnostic errors', desc = '.[N]ET solution [E]rrors' },
      { '<leader>nW', dotnet 'diagnostic warnings', desc = '.[N]ET solution [W]arnings' },
      { '<leader>no', dotnet 'outdated', desc = '.[N]ET [O]utdated packages' },
      { '<leader>na', dotnet 'add package', desc = '.[N]ET [A]dd package' },
      { '<leader>nn', dotnet 'new', desc = '.[N]ET [N]ew item/project' },
      { '<leader>n<space>', dotnet 'terminal toggle', desc = '.[N]ET toggle terminal' },
    },
    config = function()
      require('easy-dotnet').setup {
        picker = 'telescope',
        lsp = {
          enabled = true,
          -- Linux file watching can leave stale diagnostics after a checkout.
          restart_roslyn_on_branch_change = true,
          -- This repo has no Razor; skip the HTML language server lookup.
          razor = { enabled = false },
        },
        debugger = {
          engine = 'netcoredbg',
          auto_register_dap = true,
        },
        test_runner = {
          viewmode = 'vsplit',
        },
        auto_bootstrap_namespace = {
          -- The repo uses file-scoped namespaces.
          type = 'file_scoped',
          enabled = true,
        },
      }

      vim.api.nvim_create_user_command('Secrets', function()
        require('easy-dotnet').secrets()
      end, {})
    end,
  },
}
