return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},
	keys = {
		{
			"<leader>nf",
			function()
				require("neogen").generate({ type = "func" })
			end,
		},
		{
			"<leader>nt",
			function()
				require("neogen").generate({ type = "type" })
			end,
		},
	},
	config = function()
		local neogen = require("neogen")

		neogen.setup({
			snippet_engine = "luasnip",
		})
	end,
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
}
