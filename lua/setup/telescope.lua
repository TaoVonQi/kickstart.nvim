local M = {}

function M.setup()
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  -- [[ Configure Telescope ]]
  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      ['undo'] = {
        -- telescope-undo.nvim config
      },
      ['persisted'] = {},
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
  pcall(require('telescope').load_extension, 'undo')
  pcall(require('telescope').load_extension, 'persisted')

  local crates = require 'crates'

  vim.keymap.set('n', '<leader>gt', crates.toggle, { desc = 'car[g]o [t]oggle' })
  vim.keymap.set('n', '<leader>gr', crates.reload, { desc = 'car[g]o [r]eload' })

  vim.keymap.set('n', '<leader>gv', crates.show_versions_popup, { desc = 'car[g]o [v]ersions popup' })
  vim.keymap.set('n', '<leader>gf', crates.show_features_popup, { desc = 'car[g]o [f]eatures popup' })
  vim.keymap.set('n', '<leader>gd', crates.show_dependencies_popup, { desc = 'car[g]o [d]ependencies popup' })

  vim.keymap.set('n', '<leader>gu', crates.update_crate, { desc = 'car[g]o [u]pdate crate' })
  vim.keymap.set('v', '<leader>gu', crates.update_crates, { desc = 'car[g]o [u]pdate crates' })
  vim.keymap.set('n', '<leader>ga', crates.update_all_crates, { desc = 'car[g]o update [a]ll crates' })

  vim.keymap.set('n', '<leader>gx', crates.expand_plain_crate_to_inline_table, { desc = 'car[g]o e[x]pand' })
  vim.keymap.set('n', '<leader>gX', crates.extract_crate_into_table, { desc = 'car[g]o e[X]tract' })

  vim.keymap.set('n', '<leader>gH', crates.open_homepage, { desc = 'car[g]o [H]ome page' })
  vim.keymap.set('n', '<leader>gR', crates.open_repository, { desc = 'car[g]o [R]epository' })
  vim.keymap.set('n', '<leader>gD', crates.open_documentation, { desc = 'car[g]o [D]ocumentation' })
  vim.keymap.set('n', '<leader>gC', crates.open_crates_io, { desc = 'car[g]o [C]rates.io' })

  vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = 'Telescope [u]ndo' })

  vim.keymap.set('n', '<leader>p', ':Telescope persisted<cr>', { desc = '[p]ersisted sessions' })

  vim.keymap.set('n', '<leader>M', ':MCPHub<cr>', { desc = '[M]cpHub' })

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>f', builtin.buffers, { desc = '[F]ind existing buffers' })

  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

return M.setup()
