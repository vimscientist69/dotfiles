return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent"
			},
      ---@diagnostic disable-next-line: unused-local
			on_highlights = function(hl, c)
        local prompt = "#ffffff"
				hl.TelescopePromptBorder = {
					fg = prompt,
				}
				hl.TelescopePromptTitle = {
					fg = prompt,
				}
			end,
		}
	},
}

