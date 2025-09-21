require('minuet').setup {
  -- the maximum total characters of the context before and after the cursor
  -- 16000 characters typically equate to approximately 4,000 tokens for
  -- LLMs.
  context_window = 45000,

  -- when the total characters exceed the context window, the ratio of
  -- context before cursor and after cursor, the larger the ratio the more
  -- context before cursor will be used. This option should be between 0 and
  -- 1, context_ratio = 0.75 means the ratio will be 3:1.
  context_ratio = 0.75,

  throttle = 1000, -- only send the request every x milliseconds, use 0 to disable throttle.

  -- debounce the request in x milliseconds, set to 0 to disable debounce
  debounce = 500,

  -- Control notification display for request status
  -- Notification options:
  -- false: Disable all notifications (use boolean false, not string "false")
  -- "debug": Display all notifications (comprehensive debugging)
  -- "verbose": Display most notifications
  -- "warn": Display warnings and errors only
  -- "error": Display errors only
  notify = 'warn',

  -- The request timeout, measured in seconds. When streaming is enabled
  -- (stream = true), setting a shorter request_timeout allows for faster
  -- retrieval of completion items, albeit potentially incomplete.
  -- Conversely, with streaming disabled (stream = false), a timeout
  -- occurring before the LLM returns results will yield no completion items.
  request_timeout = 5,

  -- If completion item has multiple lines, create another completion item
  -- only containing its first line. This option only has impact for cmp and
  -- blink. For virtualtext, no single line entry will be added.
  add_single_line_entry = false,

  -- The number of completion items encoded as part of the prompt for the
  -- chat LLM. For FIM model, this is the number of requests to send. It's
  -- important to note that when 'add_single_line_entry' is set to true, the
  -- actual number of returned items may exceed this value. Additionally, the
  -- LLM cannot guarantee the exact number of completion items specified, as
  -- this parameter serves only as a prompt guideline.
  n_completions = 3,

  -- Length of context after cursor used to filter completion text.
  -- This setting helps prevent the language model from generating redundant
  -- text.  When filtering completions, the system compares the suffix of a
  -- completion candidate with the text immediately following the cursor.
  --
  -- If the length of the longest common substring between the end of the
  -- candidate and the beginning of the post-cursor context exceeds this
  -- value, that common portion is trimmed from the candidate.
  --
  -- For example, if the value is 15, and a completion candidate ends with a
  -- 20-character string that exactly matches the 20 characters following the
  -- cursor, the candidate will be truncated by those 20 characters before
  -- being delivered.
  after_cursor_filter_length = 15,

  -- Similar to after_cursor_filter_length but trim the completion item from
  -- prefix instead of suffix.
  before_cursor_filter_length = 2,

  provider = 'openai_fim_compatible',

  provider_options = {
    openai_fim_compatible = {
      name = 'Ollama',
      end_point = 'http://localhost:11434/v1/completions',
      api_key = 'TERM',
      -- model = 'starcoder2:7b-fp16',
      -- model = 'starcoder2:7b-q8_0',
      model = 'mydeepseek_coder_v2:16b_lite_base_q6_K',
      stream = true,
    },
  },

  virtualtext = {
    -- Specify the filetypes to enable automatic virtual text completion,
    -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
    -- completion even if the filetype is not on your auto_trigger_ft list.
    -- c,cs,cpp,go,java,javascript,kotlin,lua,php,python,r,ruby,rust,sql,sh,swift,typescript
    -- auto_trigger_ft = {
    --   'c',
    --   'cs',
    --   'cpp',
    --   'go',
    --   'java',
    --   'javascript',
    --   'kotlin',
    --   'lua',
    --   'php',
    --   'python',
    --   'r',
    --   'ruby',
    --   'rust',
    --   'sql',
    --   'sh',
    --   'swift',
    --   'typescript',
    -- },
    -- specify file types where automatic virtual text completion should be
    -- disabled. This option is useful when auto-completion is enabled for
    -- all file types i.e., when auto_trigger_ft = { '*' }
    -- auto_trigger_ignore_ft = {},

    -- Whether show virtual text suggestion when the completion menu
    -- (nvim-cmp or blink-cmp) is visible.
    -- show_on_completion_menu = true,
  },
}
