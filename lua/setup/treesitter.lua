return {
  ensure_installed = {
    'bash',
    'rust',
    'c',
    'diff',
    'html',
    'javascript',
    'css',
    'scss',
    'tsx',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'regex',
  },
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false },
}
