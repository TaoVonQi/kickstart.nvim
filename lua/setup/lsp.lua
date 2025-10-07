local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('glr', vim.lsp.buf.rename, '[R]ename')
      map('gla', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })

      -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, bufnr)
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        return diagnostic.message
      end,
    },
  }

  local blink_capabilities = require('blink.cmp').get_lsp_capabilities()
  local base_capabilities = vim.lsp.protocol.make_client_capabilities()

  base_capabilities.general = base_capabilities.general or {}
  base_capabilities.general.positionEncodings = { 'utf-16' }

  local global_capabilities = vim.tbl_deep_extend('force', {}, base_capabilities, blink_capabilities or {})

  local servers = {
    rust_analyzer = {},
    html = {},
    ruff = {},
    ts_ls = {},
    lua_ls = {},
    pyright = {
      settings = {
        pyright = { disableOrganizeImports = true },
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
          },
        },
      },
    },
    tailwindcss = {
      filetypes = {
        'rust',
        -- html
        'aspnetcorerazor',
        'astro',
        'astro-markdown',
        'blade',
        'clojure',
        'django-html',
        'htmldjango',
        'edge',
        'eelixir', -- vim ft
        'elixir',
        'ejs',
        'erb',
        'eruby', -- vim ft
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        'php',
        'razor',
        'slim',
        'twig',
        -- css
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'stylus',
        'sugarss',
        -- js
        'javascript',
        'javascriptreact',
        'reason',
        'rescript',
        'typescript',
        'typescriptreact',
        -- mixed
        'vue',
        'svelte',
        'templ',
      },
      settings = {
        tailwindCSS = {
          validate = true,
          lint = {
            cssConflict = 'warning',
            invalidApply = 'error',
            invalidScreen = 'error',
            invalidVariant = 'error',
            invalidConfigPath = 'error',
            invalidTailwindDirective = 'error',
            recommendedVariantOrder = 'warning',
          },
          classAttributes = {
            'class',
            'className',
            'class:list',
            'classList',
            'ngClass',
          },
          includeLanguages = {
            eelixir = 'html-eex',
            elixir = 'phoenix-heex',
            eruby = 'erb',
            heex = 'phoenix-heex',
            htmlangular = 'html',
            templ = 'html',
            rust = 'html',
          },
        },
      },
    },
    emmet_language_server = {
      filetypes = { 'css', 'html', 'javascript', 'rust' },
    },
  }

  local ensure_installed = vim.tbl_keys(servers or {})
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    automatic_installation = false,
  }

  for server, server_opts in pairs(servers) do
    local server_defaults = (vim.lsp.config[server] and vim.lsp.config[server].capabilities) or vim.lsp.protocol.make_client_capabilities()
    server_opts.capabilities = vim.tbl_deep_extend('force', {}, server_defaults, global_capabilities or {}, server_opts.capabilities or {})

    vim.lsp.config(server, server_opts)
  end
end

return M
