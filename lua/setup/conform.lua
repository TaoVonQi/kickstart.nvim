require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    markdown = { 'prettierd' },
    html = { 'prettierd' },
    json = { 'prettierd' },
    yaml = { 'prettierd' },
    graphql = { 'prettierd' },
    md = { 'prettierd' },
    txt = { 'prettierd' },
  },
  formatters = {
    stylua = {
      args = { '--indent-width', '2', '--indent-type', 'Spaces', '-' },
    },
  },
  -- Set up format-on-save
  -- don't want it formatting with lsp if Prettier isn't available
  format_on_save = { timeout_ms = 1500, lsp_format = 'fallback' },
}
