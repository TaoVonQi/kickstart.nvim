return {
  source_selector = {
    winbar = true,
    statusline = false,
  },
  filesystem = {
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes,
    window = {
      mappings = {
        ['s'] = {
          'show_help',
          nowait = false,
          config = { title = 'Order by', prefix_key = 'o' },
        },
        ['sc'] = { 'order_by_created', nowait = false },
        ['sd'] = { 'order_by_diagnostics', nowait = false },
        ['sg'] = { 'order_by_git_status', nowait = false },
        ['sm'] = { 'order_by_modified', nowait = false },
        ['sn'] = { 'order_by_name', nowait = false },
        ['ss'] = { 'order_by_size', nowait = false },
        ['st'] = { 'order_by_type', nowait = false },
      },
    },
  },
  window = {
    position = 'left',
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<space>'] = {
        'toggle_node',
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ['<2-LeftMouse>'] = 'open',
      ['<cr>'] = 'open',
      ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
      ['P'] = {
        'toggle_preview',
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      -- Read `# Preview Mode` for more information
      ['l'] = 'open',
      ['L'] = 'expand_all_subnodes',
      -- ['S'] = 'open_split',
      -- ['s'] = 'open_vsplit',
      ['<c-s>'] = 'split_with_window_picker',
      ['<c-v>'] = 'vsplit_with_window_picker',
      ['<c-t>'] = 'open_tabnew',
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ['o'] = 'open_with_window_picker',
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ['h'] = 'close_node',
      ['H'] = 'close_all_subnodes',
      ['z'] = 'close_all_nodes',
      ['Z'] = 'expand_all_nodes',
      ['a'] = {
        'add',
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = 'none', -- "none", "relative", "absolute"
        },
      },
      ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['b'] = 'rename_basename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
      ['i'] = 'show_file_details',
      -- ["i"] = {
      --   "show_file_details",
      --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --   -- config = {
      --   --   created_format = "%Y-%m-%d %I:%M %p",
      --   --   modified_format = "relative", -- equivalent to the line below
      --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
      --   -- }
      -- },
    },
  },
}
