return {
	{
		-- "ThePrimeagen/harpoon",
		"vimscientist69/harpoon", -- fork with support for URI buffers in quick menu
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
			},
			{
				"<leader>hv",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
			},
			{
				"<C-h>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				mode = "n",
			},
			{
				"<C-t>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
			},
			{
				"<C-n>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
			},
			{
				"<C-s>",
				function()
					require("harpoon.ui").nav_file(4)
				end,
			},
		},
	},
}
