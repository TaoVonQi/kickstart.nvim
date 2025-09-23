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

-- ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
-- local progress = vim.defaulttable()
-- vim.api.nvim_create_autocmd('LspProgress', {
--   ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
--     if not client or type(value) ~= 'table' then
--       return
--     end
--     local p = progress[client.id]
--
--     for i = 1, #p + 1 do
--       if i == #p + 1 or p[i].token == ev.data.params.token then
--         p[i] = {
--           token = ev.data.params.token,
--           msg = ('[%3d%%] %s%s'):format(
--             value.kind == 'end' and 100 or value.percentage or 100,
--             value.title or '',
--             value.message and (' **%s**'):format(value.message) or ''
--           ),
--           done = value.kind == 'end',
--         }
--         break
--       end
--     end
--
--     local msg = {} ---@type string[]
--     progress[client.id] = vim.tbl_filter(function(v)
--       return table.insert(msg, v.msg) or not v.done
--     end, p)
--
--     local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
--     vim.notify(table.concat(msg, '\n'), 'info', {
--       id = 'lsp_progress',
--       title = client.name,
--       opts = function(notif)
--         notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--       end,
--     })
--   end,
-- })
