-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Neotree [E]xplorer' })

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>j', '<Plug>(leap-forward)', { desc = '[J]ump forward' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>J', '<Plug>(leap-backward)', { desc = '[J]ump backwards' })

vim.keymap.set('n', '<C-w>t', ':tabnew<cr>', { desc = 'new [t]ab' })

vim.keymap.set('n', '<leader>ct', ':CodeCompanionChat Toggle<CR>', { desc = '[C]odecompanion [T]oggle ' })
vim.keymap.set('n', '<leader>ca', ':CodeCompanionActions<CR>', { desc = '[C]odecompanion [A]ctions ' })
vim.keymap.set('n', '<leader>cc', ':CodeCompanionCmd<CR>', { desc = '[C]odecompanion [C]md ' })
vim.keymap.set('n', '<leader>ch', ':CodeCompanionHistory<CR>', { desc = '[C]odecompanion [H]istory ' })
vim.keymap.set('n', '<leader>cs', ':CodeCompanionSummaries<CR>', { desc = '[C]odecompanion [S]ummaries ' })

vim.keymap.set('n', '<leader>tm', ':Minuet blink toggle<CR>', { desc = '[M]inuet toggle ' })

vim.keymap.set('n', '<leader>p', function()
  require('persistence').select()
end, { desc = 'Select [P]ersistencte session ' })

-- The Trouble command is a wrapper around the Trouble API. It can do anything the regular API can do.
--     Trouble [mode] [action] [options]

-- Modes:
--
--     diagnostics: diagnostics
--     loclist: Location List
--     lsp: LSP definitions, references, implementations, type definitions, and declarations
--     lsp_command: command
--     lsp_declarations: declarations
--     lsp_definitions: definitions
--     lsp_document_symbols: document symbols
--     lsp_implementations: implementations
--     lsp_incoming_calls: Incoming Calls
--     lsp_outgoing_calls: Outgoing Calls
--     lsp_references: references
--     lsp_type_definitions: type definitions
--     qflist: Quickfix List
--     quickfix: Quickfix List
--     snacks: Snacks results previously opened with require('trouble.sources.snacks').open().
--     snacks_files: Snacks results previously opened with require('trouble.sources.snacks').open().
--     symbols: document symbols

vim.keymap.set('n', '<leader>rd', '<cmd>Trouble diagnostics toggle focus=false<cr>', { desc = '[D]iagnostics All' })
vim.keymap.set('n', '<leader>rD', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>', { desc = '[D]iagnostics Buffer' })

vim.keymap.set('n', '<leader>rs', '<cmd>Trouble symbols toggle focus=false win.position=right<cr>', { desc = '[S]ymbols' })

vim.keymap.set('n', '<leader>rl', '<cmd>Trouble lsp_document_symbols toggle focus=false win.position=right<cr>', { desc = '[L]SP document symbols' })

vim.keymap.set('n', '<leader>rL', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = '[L]SP Definitions' })

vim.keymap.set('n', '<leader>rc', '<cmd>Trouble loclist toggle<cr>', { desc = 'Lo[C]ation List' })
vim.keymap.set('n', '<leader>rq', '<cmd>Trouble qflist toggle<cr>', { desc = '[Q]uickfix List' })

local splits = require 'smart-splits'
-- resizing splits
vim.keymap.set('n', '<A-h>', splits.resize_left)
vim.keymap.set('n', '<A-j>', splits.resize_down)
vim.keymap.set('n', '<A-k>', splits.resize_up)
vim.keymap.set('n', '<A-l>', splits.resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
vim.keymap.set('n', '<C-\\>', splits.move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader>wh', splits.swap_buf_left, { desc = 'S[W]ap left buffer' })
vim.keymap.set('n', '<leader>wj', splits.swap_buf_down, { desc = 'S[W]ap lower buffer' })
vim.keymap.set('n', '<leader>wk', splits.swap_buf_up, { desc = 'S[W]ap upper buffer' })
vim.keymap.set('n', '<leader>wl', splits.swap_buf_right, { desc = 'S[W]ap right buffer' })

local gitsigns = require 'gitsigns'

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Gitsigns Navigation
map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    gitsigns.nav_hunk { 'next' }
  end
end, { desc = 'Jump to next git [c]hange' })

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    gitsigns.nav_hunk { 'prev' }
  end
end, { desc = 'Jump to previous git [c]hange' })

-- visual mode
map('v', '<leader>hs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'git [s]tage hunk' })

map('v', '<leader>hr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'git [r]eset hunk' })

-- normal mode
map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

map('n', '<leader>hD', function()
  gitsigns.diffthis { '@' }
end, { desc = 'git [D]iff against last commit' })

-- Toggles
map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })

--Rust crates
local crates = require 'crates'
vim.keymap.set('n', '<leader>ot', crates.toggle, { desc = 'cargo [t]oggle' })
vim.keymap.set('n', '<leader>or', crates.reload, { desc = 'cargo [r]eload' })

vim.keymap.set('n', '<leader>ov', crates.show_versions_popup, { desc = 'cargo [v]ersions popup' })
vim.keymap.set('n', '<leader>of', crates.show_features_popup, { desc = 'cargo [f]eatures popup' })
vim.keymap.set('n', '<leader>od', crates.show_dependencies_popup, { desc = 'cargo [d]ependencies popup' })

vim.keymap.set('n', '<leader>ou', crates.update_crate, { desc = 'cargo [u]pdate crate' })
vim.keymap.set('v', '<leader>ou', crates.update_crates, { desc = 'cargo [u]pdate crates' })
vim.keymap.set('n', '<leader>oa', crates.update_all_crates, { desc = 'cargo update [a]ll crates' })

vim.keymap.set('n', '<leader>ox', crates.expand_plain_crate_to_inline_table, { desc = 'cargo e[x]pand' })
vim.keymap.set('n', '<leader>oX', crates.extract_crate_into_table, { desc = 'cargo e[X]tract' })

vim.keymap.set('n', '<leader>oH', crates.open_homepage, { desc = 'cargo [H]ome page' })
vim.keymap.set('n', '<leader>oR', crates.open_repository, { desc = 'cargo [R]epository' })
vim.keymap.set('n', '<leader>oD', crates.open_documentation, { desc = 'cargo [D]ocumentation' })
vim.keymap.set('n', '<leader>oC', crates.open_crates_io, { desc = 'cargo [C]rates.io' })
