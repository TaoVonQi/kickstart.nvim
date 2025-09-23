local M = {}

function M.opts()
  return {}
end

function M.keys()
  return {

    {
      '<leader>rd',
      '<cmd>Trouble diagnostics toggle focus=false<cr>',
      desc = 'Diagnostics All',
    },
    {
      '<leader>rD',
      '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>',
      desc = 'Diagnostics Buffer',
    },

    {
      '<leader>rs',
      '<cmd>Trouble symbols toggle pinned=true focus=false win.position=right<cr>',
      desc = 'Symbols Pinned',
    },
    {
      '<leader>rl',
      '<cmd>Trouble lsp toggle pinned=true focus=false win.position=right<cr>',
      desc = 'LSP Definitions',
    },
    {
      '<leader>rL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List',
    },
    {
      '<leader>rQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List',
    },
  }
end

return M
