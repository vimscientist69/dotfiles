return {
	{
		"mfussenegger/nvim-lint",

		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				sh = { "shellcheck" },
				zsh = { "shellcheck" },
				-- swift = { "swiftlint" },
			}

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Lint file" })
		end,
	},
}
