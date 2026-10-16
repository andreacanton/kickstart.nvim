-- Claude Code IDE integration: lets `/ide` in Claude Code connect to this Neovim
-- (selection, open file, LSP diagnostics, native diffs).
-- Uses the native terminal provider, so snacks.nvim is not required.

return {
  {
    'coder/claudecode.nvim',
    opts = {
      terminal = { provider = 'native' },
    },
    keys = {
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = '[A]I toggle [C]laude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = '[A]I [F]ocus Claude' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = '[A]I add current [B]uffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = '[A]I [S]end selection' },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = '[A]I [A]ccept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = '[A]I [D]eny diff' },
    },
  },
}
