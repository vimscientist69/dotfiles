return {
	"stevearc/oil.nvim",
	opts = {},
	keys = {
		{ "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 60,
				max_height = 30,
				border = "rounded",
			},
		})
	end,
}
