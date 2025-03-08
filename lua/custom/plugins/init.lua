-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      -- Add your configuration options here
      on_attach = function(client, bufnr)
        -- Example: if you’re using a shared on_attach from Kickstart:
        -- require("kickstart.lsp").on_attach(client, bufnr)

        -- Or put custom on_attach logic here
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        -- Example settings from the typescript-tools.nvim docs:
        expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
        -- JSXCloseTag
        -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
        -- that maybe have a conflict if enable this feature. )
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = true,
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
        publish_diagnostic_on = 'insert_leave',
        -- specify commands exposed as code_actions
        -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
        -- not exists then standard path resolution strategy is applied
        tsserver_path = nil,
        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
        -- (see 💅 `styled-components` support section)
        tsserver_plugins = {},
        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
        -- memory limit in megabytes or "auto"(basically no limit)
        tsserver_max_memory = 'auto',
        -- described below
        -- tsserver_format_options = {},
        tsserver_file_preferences = {},
        -- locale of all tsserver messages, supported locales you can find here:
        -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
        tsserver_locale = 'en',
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        -- CodeLens
        -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
        -- possible values: ("off"|"all"|"implementations_only"|"references_only")
        code_lens = 'off',
        -- by default code lenses are displayed on all referencable values and for some of you it can
        -- be too much this option reduce count of them by removing member references from lenses
        disable_member_code_lens = true,
      },
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          -- Register the Prettier (prettierd) formatter
          null_ls.builtins.formatting.prettierd,
          -- or if you installed "prettier" only:
          -- null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          -- If you want to automatically format on save, you can do:
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }
    end,
  },

  -- tailwind-tools.lua
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {}, -- your configuration
  },

  -- github copilot --
  {
    'github/copilot.vim',
  },

  -- {
  --   'rebelot/kanagawa.nvim', -- neorg needs a colorscheme with treesitter support
  --   config = function()
  --     vim.cmd.colorscheme 'kanagawa'
  --   end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- {
  --   'nvim-neorg/neorg',
  --   lazy = false,
  --   version = '*',
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ['core.defaults'] = {},
  --         ['core.concealer'] = {},
  --         ['core.dirman'] = {
  --           config = {
  --             workspaces = {
  --               notes = '~/notes',
  --             },
  --             default_workspace = 'notes',
  --           },
  --         },
  --       },
  --     }
  --
  --     vim.wo.foldlevel = 99
  --     vim.wo.conceallevel = 2
  --   end,
  -- },

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- Prisma plugins
  {
    'prisma/vim-prisma',
    ft = 'prisma', -- optional: lazy-load on Prisma filetypes
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
  {
    'pantharshit00/coc-prisma',
    ft = 'prisma', -- Optional: load on Prisma filetypes
    build = 'yarn install', -- or "npm install", if you prefer npm
  },
}
