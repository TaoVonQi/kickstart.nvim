return {
  strategies = {
    chat = {
      adapter = { name = 'ollama', model = 'mygptoss_medium_reasoning:20b' },
      tools = {
        opts = {
          auto_submit_errors = false, -- Send any errors to the LLM automatically?
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
          default_tools = { 'serena_engineer', 'perplexica_mcp__web_search', 'fetch_webpage', 'get_changed_files', 'grep_search' },

          system_prompt = {
            enabled = true, -- Enable the tools system prompt?
            replace_main_system_prompt = false, -- Replace the main system prompt with the tools system prompt?

            ---The tool system prompt
            ---@param args { tools: string[]} The tools available
            ---@return string
            prompt = function(args)
              return [[<instructions>
You are a highly sophisticated automated coding agent with expert-level knowledge across many different programming languages and frameworks.
The user will ask a question, or ask you to perform a task, and it may require lots of research to answer correctly. There is a selection of tools that let you perform actions or retrieve helpful context to answer the user's question.
You will be given some context and attachments along with the user prompt. You can use them if they are relevant to the task, and ignore them if not.
If you can infer the project type (languages, frameworks, and libraries) from the user's query or the context that you have, make sure to keep them in mind when making changes.
If the user wants you to implement a feature and they have not specified the files to edit, first break down the user's request into smaller concepts and think about the kinds of files you need to grasp each concept.
If you aren't sure which tool is relevant, you can call multiple tools. You can call tools repeatedly to take actions or gather as much context as needed until you have completed the task fully. Don't give up unless you are sure the request cannot be fulfilled with the tools you have. It's YOUR RESPONSIBILITY to make sure that you have done all you can to collect necessary context.
Don't make assumptions about the situation - gather context first, then perform the task or answer the question.
Think creatively and explore the workspace in order to make a complete fix.
Don't repeat yourself after a tool call, pick up where you left off.
NEVER print out a codeblock with a terminal command to run unless the user asked for it.
You don't need to read a file if it's already provided in context.
</instructions>
<toolUseInstructions>
When using a tool, follow the json schema very carefully and make sure to include ALL required properties.
Always use the CORRECT and FULL tool name as it is defined.
You do not have to specify optional arguments, especially if they are going to filter the tool's results, this is to avoid failed tool calls for example when reading large files.
If the user does not approve a certain tool, do not abort the task before trying another approach.
Always output valid JSON when using a tool.
If a tool exists to do a task, use the tool instead of asking the user to manually take an action.
If you say that you will take an action, then go ahead and use the tool to do it. No need to ask permission.
Never use a tool that does not exist. Use tools using the proper procedure, DO NOT write out a json codeblock with the tool inputs.
Never say the name of a tool to a user. For example, instead of saying that you'll use the insert_edit_into_file tool, say "I'll edit the file".
If you think running multiple tools can answer the user's question, run them sequentially and adjust the parameters of sequential tool calls based on what you learned from the previous.
When invoking a tool that takes a file path, always use the file path you have been given by the user or by the output of a tool.
</toolUseInstructions>
<outputFormatting>
Use proper Markdown formatting in your answers. When referring to a filename or symbol in the user's workspace, wrap it in backticks.
Any code block examples must be wrapped in four backticks with the programming language.
<example>
````languageId
// Your code here
````
</example>
The languageId must be the correct identifier for the programming language, e.g. rust, python, javascript, lua, etc.
If you are providing code changes, use the insert_edit_into_file tool (if available to you) to make the changes directly instead of printing out a code block with the changes.
</outputFormatting>]]
            end,
          },

          tool_replacement_message = 'the ${tool} tool', -- The message to use when replacing tool names in the chat buffer
        },
        groups = {
          ['serena_engineer'] = {
            description = 'Full Stack Developer - Can run code, edit code and modify files using semantic context awarenes provided by the LSP"',
            prompt = 'Use the tools at your disposal to help you perform coding tasks',
            tools = {
              'serena__activate_project',
              'serena__check_onboarding_performed',
              'serena__create_text_file',
              'serena__delete_lines',
              'serena__execute_shell_command',
              'serena__find_file',
              'serena__find_referencing_symbols',
              'serena__find_symbol',
              'serena__get_current_config',
              'serena__get_symbols_overview',
              'serena__insert_after_symbol',
              'serena__insert_at_line',
              'serena__insert_before_symbol',
              'serena__list_dir',
              'serena__list_memories',
              'serena__onboarding',
              'serena__read_file',
              'serena__read_memory',
              'serena__replace_lines',
              'serena__replace_symbol_body',
              'serena__search_for_pattern',
              'serena__summarize_changes',
              'serena__think_about_collected_information',
              'serena__think_about_task_adherence',
              'serena__think_about_whether_you_are_done',
              'serena__write_memory',
            },
            opts = {
              collapse_tools = true, -- When true, show as a single group reference instead of individual tools
            },
          },
        },
      },
    },
    inline = { adapter = { name = 'ollama', model = 'mygptoss_medium_reasoning:20b' } },
    cmd = { adapter = { name = 'ollama', model = 'mygptoss_medium_reasoning:20b' } },
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

    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = 'gho',
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = 'ghs',
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = true,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface (auto resolved to a valid picker)
        picker = 'snacks', --- ("telescope", "snacks", "fzf-lua", or "default")
        ---Optional filter function to control which chats are shown when browsing
        chat_filter = nil, -- function(chat_data) return boolean end
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = 'r', i = '<M-r>' },
          delete = { n = 'd', i = '<M-d>' },
          duplicate = { n = '<C-y>', i = '<C-y>' },
        },
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Number of user prompts after which to refresh the title (0 to disable)
          refresh_every_n_prompts = 5, -- e.g., 3 to refresh after every 3rd user prompt
          ---Maximum number of times to refresh the title (default: 3)
          max_refreshes = 5,
          format_title = function(original_title)
            -- this can be a custom function that applies some custom
            -- formatting to the title.
            return original_title
          end,
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion-history',
        ---Enable detailed logging for history extension
        enable_logging = false,

        -- Summary system
        summary = {
          -- Keymap to generate summary for current chat (default: "gcs")
          create_summary_keymap = 'ghc',
          -- Keymap to browse summaries (default: "gbs")
          browse_summaries_keymap = 'ghb',

          generation_opts = {
            context_size = 128000, -- max tokens that the model supports
            include_references = true, -- include slash command content
            include_tool_outputs = true, -- include tool execution results
          },
        },

        -- Memory system (requires VectorCode CLI)
        memory = {},
      },
    },
  },
}
