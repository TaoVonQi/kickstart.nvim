local function get_setup(name)
  return function()
    require('setup.' .. name)
  end
end

return {
  'NMAC427/guess-indent.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-unimpaired',
  'tpope/vim-surround',

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = require('setup.snacksmod').opts(),
    keys = require('setup.snacksmod').keys(),
    init = require('setup.snacksmod').init(),
  },

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'Joakker/lua-json5',
        build = './install.sh',
      },
    },
    build = 'bundled_build.lua', -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
      require('mcphub').setup {
        use_bundled_binary = true, -- Use local `mcp-hub` binary
        json_decode = require('json5').parse,
      }
    end,
  },

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ravitemer/mcphub.nvim',
      'ravitemer/codecompanion-history.nvim',
    },
    opts = require 'setup.codecompanion',
  },

  {
    'ggandor/leap.nvim',
    config = get_setup 'leap',
  },

  {
    'mrjones2014/smart-splits.nvim',
    config = get_setup 'smartsplits',
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
    end,
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = get_setup 'lint',
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl', -- See `:help ibl`
    opts = {},
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = get_setup 'autopairs',
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = require 'setup.neotree',
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = get_setup 'conform',
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'tpope/vim-fugitive' },
    config = get_setup 'lualine',
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = get_setup 'whichkey',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    dependencies = {
      'OXY2DEV/markview.nvim',
      event = 'VeryLazy',
      opts = require 'setup.markview',
    },

    opts = require 'setup.treesitter',
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      'xzbdmw/colorful-menu.nvim',
      'archie-judd/blink-cmp-words',
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      {
        'milanglacier/minuet-ai.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = get_setup 'minuet',
      },
      {
        -- Snippet Engine
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    opts = require 'setup.blink',
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason.nvim',
        config = function()
          require('mason').setup {}
        end,
      },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {}
        end,
      },
      {
        'onsails/lspkind.nvim',
        config = function()
          require('lspkind').setup {
            mode = 'symbol_text',
            preset = 'default',
          }
        end,
      },
    },
    config = get_setup 'lsp',
  },

  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup {}
    end,
  },

  { --vim-illuminate
    'RRethy/vim-illuminate',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = get_setup 'illuminate',
  },

  -- {
  --   'nvim-telescope/telescope.nvim',
  --   event = 'VimEnter',
  --   dependencies = {
  --     'debugloop/telescope-undo.nvim',
  --     'nvim-lua/plenary.nvim',
  --     {
  --       'nvim-telescope/telescope-fzf-native.nvim',
  --       build = 'make',
  --       cond = function()
  --         return vim.fn.executable 'make' == 1
  --       end,
  --     },
  --     { 'nvim-telescope/telescope-ui-select.nvim' },
  --
  --     { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  --
  --     {
  --       'olimorris/persisted.nvim',
  --       config = get_setup 'persisted',
  --     },
  --   },
  --   config = get_setup 'telescope',
  -- },
}
