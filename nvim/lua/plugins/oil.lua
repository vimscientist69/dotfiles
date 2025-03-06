return {
	"stevearc/oil.nvim",
	opts = {
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-p>"] = false,
			["<leader><C-p>"] = "actions.preview",
		},
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
	},
	lazy = false,
	keys = {
		{ "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
