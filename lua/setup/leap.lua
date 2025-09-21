local M = {}

function M.setup()
  vim.keymap.set({ 'n', 'v', 'x' }, '<leader>l', '<Plug>(leap-forward)', { desc = '[l]eap forward' })
  vim.keymap.set({ 'n', 'v', 'x' }, '<leader>L', '<Plug>(leap-backward)', { desc = '[L]eap backwards' })
end

return M.setup()
