return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-tree/nvim-web-devicons", opts = {} },
		},
		keys = {
			{ "<leader>mf", "<cmd>Telescope media_files<cr>", desc = "Telescope media files" },

			-- This mappings got replaced with snacks.nvim picker
			-- { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
			-- {
			-- 	"<leader>ne",
			-- 	function()
			-- 		require("telescope.builtin").find_files({
			-- 			cwd = vim.fn.stdpath("config"),
			-- 		})
			-- 	end,
			-- 	desc = "Telescope find file in Neovim configuration",
			-- },
			-- { "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep (project search)" },
			-- { "<leader>tb", "<cmd>Telescope builtin<cr>", desc = "Telescope builtin pickers" },
			-- { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Telescope git files" },
			-- { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope find references" },
			-- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
			-- { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
		},
		opts = {
			load_extension = {
				media_files = "media_files",
			},
		},
	},
}
