return {
	"nvimdev/lspsaga.nvim",
	config = function()
		vim.diagnostic.config({
			severity_sort = true,
		})
		require("lspsaga").setup({})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
