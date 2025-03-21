return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	keys = {
		{
			"]s",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			desc = "Navigate to next hunk",
		},
		{
			"[s",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
			desc = "Navigate to previous hunk",
		},
		{
			"<leader>hs",
			"<cmd>Gitsigns stage_hunk<CR>",
			desc = "Stage hunk",
		},
		{
			"<leader>hr",
			"<cmd>Gitsigns reset_hunk<CR>",
			desc = "Reset hunk",
		},
		{
			"<leader>hr",
			"<cmd>Gitsigns reset_hunk<CR>",
			desc = "Reset hunk",
		},
		{
			"<leader>hs",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Stage hunk",
			mode = { "v" },
		},
		{
			"<leader>hr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "Reset hunk",
			mode = { "v" },
		},
		{
			"<leader>hS",
			function()
				require("gitsigns").stage_buffer()
			end,
			desc = "Stage buffer",
		},
		{
			"<leader>hR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "Reset buffer",
		},
		{
			"<leader>hp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Preview hunk",
		},
		{
			"<leader>hi",
			function()
				require("gitsigns").preview_hunk_inline()
			end,
			desc = "Preview hunk inline",
		},
		{
			"<leader>hb",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			desc = "Blame line",
		},
		{
			"<leader>hd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "Diff this",
		},
		{
			"<leader>hD",
			function()
				require("gitsigns").diffthis("~")
			end,
			desc = "Diff this (ignore whitespace)",
		},
		{
			"<leader>hQ",
			function()
				require("gitsigns").setqflist("all")
			end,
			desc = "Set quickfix list (all)",
		},
		{
			"<leader>hq",
			function()
				---@diagnostic disable-next-line: missing-parameter
				require("gitsigns").setqflist()
			end,
			desc = "Set quickfix list",
		},
		{
			"<leader>tb",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle blame",
		},
		{
			"<leader>tw",
			function()
				require("gitsigns").toggle_word_diff()
			end,
			desc = "Toggle word diff",
		},
		{
			"ih",
			mode = { "o", "x" },
			function()
				require("gitsigns").select_hunk()
			end,
			desc = "Select hunk",
		},
	},
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "*" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "*" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
}
