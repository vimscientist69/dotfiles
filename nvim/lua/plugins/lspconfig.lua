return {
  {
    "williamboman/mason.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      ensure_installed = { "lua_ls", "rust_analyzer" },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        {
          "petertriho/cmp-git",
          dependencies = { 'hrsh7th/nvim-cmp' },
          opts = {
            filetypes = { "gitcommit", "octo", "NeogitCommitMessage", "lua" },
          },
        },
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip"
      },
      config = function()
        local cmp = require 'cmp'
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },

          mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),

          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
            { name = 'git' },
          },
          {
            { name = 'buffer' },
          }
        })

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )

        require("cmp_git").setup()


        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
        })

        require("mason").setup()
        require("fidget").setup({})
        require("mason-lspconfig").setup {
          ensure_installed = { "lua_ls", "rust_analyzer" },
        }
        local lspconfig = require("lspconfig")

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.lua_ls.setup {
          capabilities = capabilities,
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            })
          end,
          settings = {
            Lua = {}
          }
        }
        local sourcekit_capabilities = vim.tbl_deep_extend(
          "keep",
          {},
          {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
          capabilities
        )

        lspconfig.sourcekit.setup {
          capabilities = sourcekit_capabilities
        }

        vim.diagnostic.config({
          -- update_in_insert = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
          },
        })
      end
    },
  }
}
