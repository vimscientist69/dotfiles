return {
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"mbbill/undotree",
		keys = {
			{
				"<leader>tu",
				"<cmd>UndotreeToggle<CR>",
				desc = "Undo Tree Toggle",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ignore_install = {},
				modules = {},
				-- A list of parser names, or "all"
				ensure_installed = {
					"dockerfile",
					"yaml",
					"html",
					"json",
					"toml",
					"vimdoc",
					"javascript",
					"regex",
					"vim",
					"markdown",
					"markdown_inline",
					"typescript",
					"c",
					"lua",
					"rust",
					"jsdoc",
					"bash",
					"swift",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})

			vim.treesitter.language.register("bash", "env")
		end,
	},
}
