return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
			{ "nvim-tree/nvim-web-devicons", opts = {} },
		},
		keys = {
      			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      			{
				"<leader>en",
				function()
					require("telescope.builtin").find_files {
						cwd = vim.fn.stdpath("config")
					}
				end,
				desc = "Telescope find file in Neovim configuration"
			},
      			{ "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep (project search)" },
      			{ "<leader>tb", "<cmd>Telescope builtin<cr>", desc = "Telescope builtin pickers" },
      			{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope find references" },
      			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" }
		},
	}
}
