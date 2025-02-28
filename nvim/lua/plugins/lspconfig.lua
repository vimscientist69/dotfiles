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
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
				'hrsh7th/cmp-vsnip',
				'hrsh7th/vim-vsnip'
			},
			config = function()
				local cmp = require'cmp'

				cmp.setup({
					snippet = {
						-- REQUIRED - you must specify a snippet engine
						expand = function(args)
							vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
							-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
							-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
							-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
							-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

							-- For `mini.snippets` users:
							-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
							-- insert({ body = args.body }) -- Insert at cursor
							-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
							-- require("cmp.config").set_onetime({ sources = {} })
						end,
					},
					window = {
						-- completion = cmp.config.window.bordered(),
						-- documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'vsnip' }, -- For vsnip users.
						-- { name = 'luasnip' }, -- For luasnip users.
						-- { name = 'ultisnips' }, -- For ultisnips users.
						-- { name = 'snippy' }, -- For snippy users.
					}, {
						{ name = 'buffer' },
					})
				})

				-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
				-- Set configuration for specific filetype.
				--[[ cmp.setup.filetype('gitcommit', {
					sources = cmp.config.sources({
						{ name = 'git' },
					}, {
						{ name = 'buffer' },
					})
				})
				require("cmp_git").setup() ]]-- 

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
							if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
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


			end
		},
	}
}
