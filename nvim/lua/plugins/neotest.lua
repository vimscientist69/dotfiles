return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"mmllr/neotest-swift-testing",
		},

		keys = {
			{
				"<leader>tc",
				function()
					require("neotest").run.run()
				end,
				desc = "Run test under cursor.",
			},
			{
				"<leader>tt",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle output panel.",
			},
			{
				"<leader>tx",
				function()
					require("neotest").output_panel.clear()
				end,
				desc = "Clear output panel.",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run all tests in current file.",
			},
		},
		config = function()
			local neotest = require("neotest")
			---@diagnostic disable-next-line: missing-fields
			neotest.setup({
				adapters = {
					require("neotest-python"),
					require("neotest-swift-testing"),
				},
			})
		end,
	},
}
