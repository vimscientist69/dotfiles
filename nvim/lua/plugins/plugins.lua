-- Small utility plugins

return {
	{
		"Wansmer/treesj",
		keys = {
			{ "T", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 150,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- If you want insert `(` after select function or method item
		--
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{ "ThePrimeagen/vim-be-good" },
}
