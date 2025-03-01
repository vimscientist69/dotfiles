return {
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"hrsh7th/nvim-cmp",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				{
					"petertriho/cmp-git",
					dependencies = { "hrsh7th/nvim-cmp" },
					opts = {
						filetypes = { "gitcommit", "octo", "NeogitCommitMessage", "lua" },
					},
				},
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				{
					"j-hui/fidget.nvim",
					opts = {
						notification = {
							window = {
								winblend = 0,
							},
						},
					},
				},
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				{
					-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
					-- used for completion, annotations and signatures of Neovim apis
					"folke/lazydev.nvim",
					ft = "lua",
					opts = {
						library = {
							-- Load luvit types when the `vim.uv` word is found
							-- { path = "luvit-meta/library",      words = { "vim%.uv" } },
							-- { path = "/usr/share/awesome/lib/", words = { "awesome" } },
						},
					},
				},
			},
			config = function()
				local cmp = require("cmp")
				local cmp_select = { behavior = cmp.SelectBehavior.Select }

				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},

					mapping = cmp.mapping.preset.insert({
						["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
						["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),

					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" }, -- For luasnip users.
						{ name = "git" },
					},
					{
						{ name = "buffer" },
					},
				})

				-- If you want insert `(` after select function or method item
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

				require("cmp_git").setup({})

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				})

				-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				})

				require("mason").setup()
				local ensure_installed =
					{ "lua_ls", "rust_analyzer", "bashls", "shfmt", "shellcheck", "html", "stylua" }
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				local lspconfig = require("lspconfig")

				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				lspconfig.lua_ls.setup({
					capabilities = capabilities,
				})

				lspconfig.sourcekit.setup({
					capabilities = vim.tbl_deep_extend("keep", {}, {
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					}, capabilities),
				})

				lspconfig.bashls.setup({
					capabilities = capabilities,
					settings = {
						filetypes = { "sh", "zsh" },
					},
				})

				lspconfig.html.setup({
					capabilities = capabilities,
				})

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
			end,
		},
	},
}
