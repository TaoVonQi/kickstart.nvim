local M = {}

function M.setup()
  vim.keymap.set('n', '<C-n>', require('illuminate').goto_next_reference, { desc = 'Move to next reference' })

  vim.keymap.set('n', '<C-p>', require('illuminate').goto_prev_reference, { desc = 'Move to previous reference' })

  require('illuminate').configure {
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'nvim-treesitter',
      'lsp',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 50,
  }
end

return M.setup()
