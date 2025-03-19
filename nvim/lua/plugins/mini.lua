return {
	"echasnovski/mini.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = { F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }) },
		})

		local surround = require("mini.operators")
		surround.setup()

		local operators = require("mini.surround")
		operators.setup()

		vim.keymap.set("n", "<leader>ol", "<Cmd>normal gxiagxina<CR>")
		vim.keymap.set("n", "<leader>oh", "<Cmd>normal gxiagxila<CR>")
	end,
}
