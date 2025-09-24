-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  desc = 'Close all NeoTree buffers across all tabs',
  group = vim.api.nvim_create_augroup('NeoTreeBufferCleanup', { clear = true }),
  callback = function()
    -- Close all buffers with neo-tree filetype regardless of tab
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'neo-tree' then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  desc = 'Close all codecompanion buffers across all tabs',
  group = vim.api.nvim_create_augroup('CodecompanionBufferCleanup', { clear = true }),
  callback = function()
    -- Close all buffers with codecompanion filetype regardless of tab
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'codecompanion' then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  callback = function()
    vim.cmd [[Trouble qflist open]]
  end,
})
