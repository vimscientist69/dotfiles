return {
	"pwntester/octo.nvim",
	commit = "e78daef",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{
			"<leader>oa",
			"<cmd>Octo actions<CR>",
			desc = "Open all Octo actions",
		},
		{
			"<leader>orl",
			"<cmd>Octo run list<CR>",
			desc = "list workflow runs",
		},
		{
			"<leader>opo",
			"<cmd>Octo pr<CR>",
			desc = "open current pull request",
		},
		{
			"<leader>onl",
			"<cmd>Octo notification list<CR>",
			desc = "list notifications",
		},
		{
			"<leader>ona",
			"<cmd>Octo notification all<CR>",
			desc = "list all notifications",
		},
		{
			"<leader>opC",
			"<cmd>Octo pr checkout<CR>",
			desc = "checkout pull request",
		},
		{
			"<leader>opl",
			"<cmd>Octo pr list<CR>",
			desc = "list pull requests",
		},
		{
			"<leader>ops",
			"<cmd>Octo pr search<CR>",
			desc = "search pull requests",
		},
		{
			"<leader>opc",
			"<cmd>Octo pr create<CR>",
			desc = "create a pull request",
		},
		{
			"<leader>oil",
			"<cmd>Octo issue list<CR>",
			desc = "list issues",
		},
		{
			"<leader>oic",
			"<cmd>Octo issue create<CR>",
			desc = "create issue",
		},
		{
			"<leader>orb",
			"<cmd>Octo repo browser<CR>",
			desc = "Open repository in browser",
		},
	},
	opts = {
		use_local_fs = false, -- use local files on right side of reviews
		enable_builtin = false, -- shows a list of builtin actions when no action is provided
		default_remote = { "upstream", "origin" }, -- order to try remotes
		default_merge_method = "squash", -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `commit`, `rebase` or `squash`
		default_delete_branch = true, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
		ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`. The key part will be interpreted as an anchored Lua pattern.
		picker = "telescope", -- or "fzf-lua"
		picker_config = {
			use_emojis = false, -- only used by "fzf-lua" picker for now
			mappings = { -- mappings for the pickers
				open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
				merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
			},
		},
		comment_icon = "▎", -- comment marker
		outdated_icon = "󰅒 ", -- outdated indicator
		resolved_icon = " ", -- resolved indicator
		reaction_viewer_hint_icon = " ", -- marker for user reactions
		commands = {
			notification = {
				list = function()
					local utils = require("octo.utils")

					local opts = {}

					if vim.fn.confirm("Current Repo Only?", "&Yes\n&No", 1) == 1 then
						opts.repo = utils.get_remote_name()
					end

					require("octo.picker").notifications(opts)
				end,
				all = function()
					local utils = require("octo.utils")

					local opts = { all = true }

					if vim.fn.confirm("Current Repo Only?", "&Yes\n&No", 1) == 1 then
						opts.repo = utils.get_remote_name()
					end

					require("octo.picker").notifications(opts)
				end,
			},
		}, -- additional subcommands made available to `Octo` command
		users = "assignable", -- Users for assignees or reviewers. Values: "search" | "mentionable" | "assignable"
		user_icon = " ", -- user icon
		ghost_icon = "󰊠 ", -- ghost icon
		timeline_marker = " ", -- timeline marker
		timeline_indent = "2", -- timeline indentation
		right_bubble_delimiter = "", -- bubble delimiter
		left_bubble_delimiter = "", -- bubble delimiter
		github_hostname = "", -- GitHub Enterprise host
		snippet_context_lines = 4, -- number or lines around commented lines
		gh_cmd = "gh", -- Command to use when calling Github CLI
		gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
		timeout = 5000, -- timeout for requests between the remote server
		default_to_projects_v2 = false, -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
		ui = {
			use_signcolumn = false, -- show "modified" marks on the sign column
			use_signstatus = true, -- show "modified" marks on the status column
		},
		issues = {
			order_by = { -- criteria to sort results of `Octo issue list`
				field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
				direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
			},
		},
		reviews = {
			auto_show_threads = true, -- automatically show comment threads on cursor move
			focus = "right", -- focus right buffer on diff open
		},
		runs = {
			icons = {
				pending = "🕖",
				in_progress = "🔄",
				failed = "❌",
				succeeded = "",
				skipped = "⏩",
				cancelled = "✖",
			},
		},
		pull_requests = {
			order_by = { -- criteria to sort the results of `Octo pr list`
				field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
				direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
			},
			always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
		},
		notifications = {
			current_repo_only = false, -- show notifications for current repo only
		},
		file_panel = {
			size = 10, -- changed files panel rows
			use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
		},
		colors = { -- used for highlight groups (see Colors section below)
			white = "#ffffff",
			grey = "#2A354C",
			black = "#000000",
			red = "#fdb8c0",
			dark_red = "#da3633",
			green = "#acf2bd",
			dark_green = "#238636",
			yellow = "#d3c846",
			dark_yellow = "#735c0f",
			blue = "#58A6FF",
			dark_blue = "#0366d6",
			purple = "#6f42c1",
		},
		mappings_disable_default = false, -- disable default mappings if true, but will still adapt user mappings
		mappings = {
			runs = {
				expand_step = { lhs = "o", desc = "expand workflow step" },
				open_in_browser = { lhs = "<C-b>", desc = "open workflow run in browser" },
				refresh = { lhs = "<C-r>", desc = "refresh workflow" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
			},
			issue = {
				close_issue = { lhs = "<leader>oiC", desc = "close issue" },
				reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
				-- list_issues = { lhs = "<leader>oil", desc = "list open issues on same repo" },
				reload = { lhs = "<C-r>", desc = "reload issue" },
				open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
				remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
				create_label = { lhs = "<leader>lc", desc = "create label" },
				add_label = { lhs = "<leader>la", desc = "add label" },
				remove_label = { lhs = "<leader>ld", desc = "remove label" },
				goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<leader>ca", desc = "add comment" },
				delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
			},
			pull_request = {
				checkrout_pr = { lhs = "<leader>po", desc = "checkout PR" },
				merge_pr = { lhs = "<leader>pm", desc = "merge commit PR" },
				squash_and_merge_pr = { lhs = "<leader>opsm", desc = "squash and merge PR" },
				rebase_and_merge_pr = { lhs = "<leader>oprm", desc = "rebase and merge PR" },
				list_commits = { lhs = "<leader>pc", desc = "list PR commits" },
				list_changed_files = { lhs = "<leader>pF", desc = "list PR changed files" },
				show_pr_diff = { lhs = "<leader>pd", desc = "show PR diff" },
				add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
				remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer request" },
				close_issue = { lhs = "<leader>ic", desc = "close PR" },
				reopen_issue = { lhs = "<leader>io", desc = "reopen PR" },
				list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
				reload = { lhs = "<C-r>", desc = "reload PR" },
				open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				goto_file = { lhs = "gf", desc = "go to file" },
				add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
				remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
				create_label = { lhs = "<leader>lc", desc = "create label" },
				add_label = { lhs = "<leader>la", desc = "add label" },
				remove_label = { lhs = "<leader>ld", desc = "remove label" },
				goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<leader>ca", desc = "add comment" },
				delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
				review_start = { lhs = "<leader>vs", desc = "start a review for the current PR" },
				review_resume = { lhs = "<leader>ovr", desc = "resume a pending review for the current PR" },
				resolve_thread = { lhs = "<leader>rt", desc = "resolve PR thread" },
				unresolve_thread = { lhs = "<leader>rT", desc = "unresolve PR thread" },
			},
			review_thread = {
				goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<leader>ca", desc = "add comment" },
				add_suggestion = { lhs = "<leader>osa", desc = "add suggestion" },
				delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				select_next_entry = { lhs = "]q", desc = "move to next changed file" },
				select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
				select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
				select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
				close_review_tab = { lhs = "<leader><C-c>", desc = "close review tab" },
				react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
				resolve_thread = { lhs = "<leader>rt", desc = "resolve PR thread" },
				unresolve_thread = { lhs = "<leader>rT", desc = "unresolve PR thread" },
			},
			submit_win = {
				approve_review = { lhs = "<C-a>", desc = "approve review", mode = { "n", "i" } },
				comment_review = { lhs = "<C-m>", desc = "comment review", mode = { "n", "i" } },
				request_changes = { lhs = "<C-r>", desc = "request changes review", mode = { "n", "i" } },
				close_review_tab = { lhs = "<leader><C-c>", desc = "close review tab", mode = { "n", "i" } },
			},
			review_diff = {
				submit_review = { lhs = "<leader>vs", desc = "submit review" },
				discard_review = { lhs = "<leader>ovd", desc = "discard review" },
				add_review_comment = {
					lhs = "<leader>ca",
					desc = "add a new review comment",
					mode = { "n", "x" },
				},
				add_review_suggestion = {
					lhs = "<leader>sa",
					desc = "add a new review suggestion",
					mode = { "n", "x" },
				},
				focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
				toggle_files = { lhs = "<leader>ob", desc = "hide/show changed files panel" },
				next_thread = { lhs = "]T", desc = "move to next thread" },
				prev_thread = { lhs = "[T", desc = "move to previous thread" },
				select_next_entry = { lhs = "<leader>j", desc = "move to next changed file" },
				select_prev_entry = { lhs = "<leader>k", desc = "move to previous changed file" },
				select_first_entry = { lhs = "<leader>J", desc = "move to first changed file" },
				select_last_entry = { lhs = "<leader>K", desc = "move to last changed file" },
				close_review_tab = { lhs = "<C-C>", desc = "close review tab" },
				toggle_viewed = { lhs = "<leader>Ov", desc = "toggle viewer viewed state" },
				goto_file = { lhs = "gf", desc = "go to file" },
			},
			file_panel = {
				submit_review = { lhs = "<leader>vs", desc = "submit review" },
				discard_review = { lhs = "<leader>ovd", desc = "discard review" },
				next_entry = { lhs = "j", desc = "move to next changed file" },
				prev_entry = { lhs = "k", desc = "move to previous changed file" },
				select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
				refresh_files = { lhs = "R", desc = "refresh changed files panel" },
				focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
				toggle_files = { lhs = "<leader>ob", desc = "hide/show changed files panel" },
				-- select_next_entry = { lhs = "<leader>j", desc = "move to next changed file" },
				-- select_prev_entry = { lhs = "<leader>k", desc = "move to previous changed file" },
				-- select_first_entry = { lhs = "<leader>J", desc = "move to first changed file" },
				-- select_last_entry = { lhs = "<leader>K", desc = "move to last changed file" },
				close_review_tab = { lhs = "<C-C>", desc = "close review tab" },
				toggle_viewed = { lhs = "<leader>Ov", desc = "toggle viewer viewed state" },
			},
			notification = {
				read = { lhs = "<leader>rn", desc = "mark notification as read" },
			},
		},
	},
}
