return {
  -- adapters = {
  --   http = {
  --     opts = {
  --       show_defaults = false,
  --       show_model_choices = true,
  --     },
  --   },
  -- },
  strategies = {
    cmd = { adapter = { name = 'ollama', model = 'mygptoss_medium_reasoning:20b' } },
    inline = { adapter = { name = 'ollama', model = 'mygptoss_high_reasoning:20b' } },
    chat = {
      adapter = { name = 'ollama', model = 'mygptoss_high_reasoning:20b' },
      opts = {
        ---Decorate the user message before it's sent to the LLM
        prompt_decorator = function(message, adapter, context)
          return string.format([[<prompt>%s</prompt>]], message)
        end,
      },
      tools = {
        opts = {
          auto_submit_errors = true, -- Send any errors to the LLM automatically?
          auto_submit_success = true, -- Send any successful output to the LLM automatically?
          folds = {
            enabled = true, -- Fold tool output in the buffer?
            failure_words = { -- Words that indicate an error in the tool output. Used to apply failure highlighting
              'cancelled',
              'error',
              'failed',
              'incorrect',
              'invalid',
              'rejected',
            },
          },
          ---Tools and/or groups that are always loaded in a chat buffer
          ---@type string[]
          default_tools = {
            'pair_programmer',
          },

          tool_replacement_message = 'the ${tool} tool', -- The message to use when replacing tool names in the chat buffer
        },
        groups = {
          ['pair_programmer'] = {
            description = 'Pair programmer engineer - can search the web, run code, edit code and modify files',
            tools = {
              'perplexica_mcp__web_search',
              'fetch_webpage',
              'cmd_runner',
              'grep_search',
              'file_search',
              'create_file',
              'read_file',
              'get_changed_files',
              'insert_edit_into_file',
              'next_edit_suggestion',
              'list_code_usages',
            },
            opts = {
              collapse_tools = true, -- When true, show as a single group reference instead of individual tools
            },
          },
        },
      },
    },
  },
  display = {

    action_palette = {
      width = 180,
      height = 50,
      provider = 'snacks', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        title = 'CodeCompanion actions', -- The title of the action palette
      },
    },
    diff = {
      enabled = true,
      provider = split, -- mini_diff|split|inline

      provider_opts = {
        -- Options for inline diff provider
        inline = {
          layout = 'float', -- float|buffer - Where to display the diff

          diff_signs = {
            signs = {
              text = '▌', -- Sign text for normal changes
              reject = '✗', -- Sign text for rejected changes in super_diff
              highlight_groups = {
                addition = 'DiagnosticOk',
                deletion = 'DiagnosticError',
                modification = 'DiagnosticWarn',
              },
            },
            -- Super Diff options
            icons = {
              accepted = ' ',
              rejected = ' ',
            },
            colors = {
              accepted = 'DiagnosticOk',
              rejected = 'DiagnosticError',
            },
          },

          opts = {
            context_lines = 3, -- Number of context lines in hunks
            dim = 25, -- Background dim level for floating diff (0-100, [100 full transparent], only applies when layout = "float")
            full_width_removed = true, -- Make removed lines span full width
            show_keymap_hints = true, -- Show "gda: accept | gdr: reject" hints above diff
            show_removed = true, -- Show removed lines as virtual text
          },
        },

        -- Options for the split provider
        split = {
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = 'vertical', -- vertical|horizontal split
          opts = {
            'internal',
            'filler',
            'closeoff',
            'algorithm:histogram', -- https://adamj.eu/tech/2024/01/18/git-improve-diff-histogram/
            'indent-heuristic', -- https://blog.k-nut.eu/better-git-diffs
            'followwrap',
            'linematch:120',
          },
        },
      },
    },
  },
  extensions = {
    mcphub = {
      callback = 'mcphub.extensions.codecompanion',
      opts = {
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        show_result_in_chat = true, -- Show tool results directly in chat buffer
        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
        -- MCP Resources
        make_vars = true, -- Convert MCP resources to #variables for prompts
        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
  },
}
