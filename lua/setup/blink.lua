return {
  keymap = {
    -- 'default' <c-y> to accept ([y]es) the completion.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'default',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {

    ghost_text = { enabled = true },

    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },

    documentation = { auto_show = true, auto_show_delay_ms = 50, window = { border = 'rounded' } },

    trigger = { prefetch_on_insert = false },

    menu = {
      border = 'rounded',
      draw = {
        -- We don't need label_description now because label and label_description are already
        -- combined together in label by colorful-menu.nvim.
        columns = { { 'kind_icon', 'kind', gap = 1 }, { 'label' } },
        components = {
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx)
              local highlights_info = require('colorful-menu').blink_highlights(ctx)
              if highlights_info ~= nil then
                -- Or you want to add more item to label
                return highlights_info.label
              else
                return ctx.label
              end
            end,
            highlight = function(ctx)
              local highlights = {}
              local highlights_info = require('colorful-menu').blink_highlights(ctx)
              if highlights_info ~= nil then
                highlights = highlights_info.highlights
              end
              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
              end
              -- Do something else
              return highlights
            end,
          },
        },
      },
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'minuet', 'buffer', 'lazydev', 'dictionary', 'thesaurus' },

    providers = {

      lazydev = { module = 'lazydev.integrations.blink', score_offset = 9 },

      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },

      path = {
        name = 'PATH',
        score_offset = 9, -- higher = more preferred
      },

      minuet = {
        name = 'FIM',
        score_offset = 8, -- Gives minuet higher priority among suggestions

        module = 'minuet.blink',
        async = true,
        -- Should match minuet.config.request_timeout * 1000,
        -- since minuet.config.request_timeout is in seconds
        timeout_ms = 5000,
      },

      lsp = {
        name = 'LSP',
        score_offset = 7,
      },

      snippets = {
        name = 'SNPT',
        score_offset = 6,
      },

      -- Use the thesaurus source
      thesaurus = {
        name = 'DICT',
        module = 'blink-cmp-words.thesaurus',
        -- All available options
        opts = {
          -- A score offset applied to returned items.
          -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
          score_offset = 0,

          -- Default pointers define the lexical relations listed under each definition,
          -- see Pointer Symbols below.
          -- Default is as below ("antonyms", "similar to" and "also see").
          definition_pointers = { '!', '&', '^' },

          -- The pointers that are considered similar words when using the thesaurus,
          -- see Pointer Symbols below.
          -- Default is as below ("similar to", "also see" }
          similarity_pointers = { '&', '^' },

          -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
          -- 2 is similar words of similar words, etc. Increasing this may slow results.
          similarity_depth = 2,
        },
      },

      -- Use the dictionary source
      dictionary = {
        name = 'DICT',
        module = 'blink-cmp-words.dictionary',
        -- All available options
        opts = {
          -- The number of characters required to trigger completion.
          -- Set this higher if completion is slow, 3 is default.
          dictionary_search_threshold = 3,

          -- See above
          score_offset = 0,

          -- See above
          definition_pointers = { '!', '&', '^' },
        },
      },
    },

    per_filetype = {
      sql = { 'minuet', 'snippets', 'dadbod', 'buffer' },
      codecompanion = { 'codecompanion', 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'dictionary', 'thesaurus' },
    },
  },
}
