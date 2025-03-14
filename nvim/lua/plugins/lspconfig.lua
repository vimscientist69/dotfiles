return {
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"neovim/nvim-lspconfig",
			dependencies = {
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
				require("mason").setup()
				local ensure_installed = {
					"codelldb",
					"lua_ls",
					"rust_analyzer",
					"bashls",
					"shfmt",
					"shellcheck",
					"html",
					"stylua",
					"python-lsp-server",
					"swiftlint",
				}
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				local lspconfig = require("lspconfig")

				lspconfig.lua_ls.setup({
					capabilities = capabilities,
				})

				lspconfig.sourcekit.setup({
					capabilities = vim.tbl_deep_extend("keep", {
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					}, capabilities),
				})

				lspconfig.bashls.setup({
					capabilities = capabilities,
					filetypes = { "sh", "zsh" },
				})

				lspconfig.html.setup({
					capabilities = capabilities,
				})

				require("lspconfig").pylsp.setup({})

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
