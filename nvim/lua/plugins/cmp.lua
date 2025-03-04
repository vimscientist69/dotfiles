return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
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
				"L3MON4D3/LuaSnip",
				opts = {
					set_config = {
						history = false,
						updateevents = "TextChanged,TextChangedI",
					},
				},
				keys = {
					{
						"<C-k>",
						function()
							local ls = require("luasnip")
							if ls.expand_or_jumpable() then
								ls.expand_or_jump()
							end
						end,
						silent = true,
						mode = { "i", "s" },
					},
					{
						"<C-j>",
						function()
							local ls = require("luasnip")
							if ls.jumpable(-1) then
								ls.jump(-1)
							end
						end,
						silent = true,
						mode = { "i", "s" },
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
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
					{ name = "path" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "git" },
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
					{ name = "cmdline" },
					{ name = "path" },
				}, {}),
			})

			-- Setup up vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
		end,
	},
}
