return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"wojciech-kulik/xcodebuild.nvim",
	},
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

			-- On windows you may have to uncomment this:
			-- detached = false,
		}

		local xcode_path = vim.fn.trim(vim.fn.system("xcode-select -p"))
		-- dap.adapters.lldb = {
		-- 	type = "executable",
		-- 	command = xcode_path .. "/usr/bin/lldb-dap",
		-- 	name = "lldb",
		-- }

		dap.configurations.swift = {
			{
				name = "Vapor project",
				type = "codelldb",
				-- type = "lldb",
				request = "launch",
				program = function()
					-- Ensure the project is built before launching
					-- print("Building project")
					-- vim.fn.system("swift build")
					-- print("Project built successfully")
					require("dapui").open()
					-- Return the path to the compiled executable
					return vim.fn.getcwd() .. "/.build/debug/App"
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = { "serve" }, -- Pass "serve" as an argument
			},
		}

		vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Continue" })
		vim.keymap.set(
			"n",
			"<leader>db",
			"<cmd>lua require('dap').toggle_breakpoint()<CR>",
			{ desc = "Toggle Breakpoint" }
		)
		vim.keymap.set("n", "<leader>Sn", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
		vim.keymap.set("n", "<leader>Si", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
		vim.keymap.set("n", "<leader>So", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })
		vim.keymap.set("n", "<leader>bd", "<cmd>lua require('dap').run_last()<CR>", { desc = "Run Last" })
		-- create a mapping to hover over variables to see their values
		vim.keymap.set("n", "<leader>dh", "<cmd>lua require('dapui').eval()<CR>", { desc = "Hover" })

		-- dap.configurations.swift = {
		-- 	{
		-- 		name = "Launch file",
		-- 		type = "lldb",
		-- 		request = "launch",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 		end,
		-- 		cwd = "${workspaceFolder}",
		-- 		stopOnEntry = false,
		-- 	},
		-- }
		-- if not dap.adapters.lldb then
		-- 	dap.adapters.lldb = {
		-- 		type = "executable",
		-- 		command = xcode_path .. "/usr/bin/lldb-dap",
		-- 		name = "lldb",
		-- 	}
		-- end
		-- local xcodebuild = require("xcodebuild.integrations.dap")
		-- -- TODO: change it to your local codelldb path
		-- local codelldbPath = "codelldb"
		-- xcodebuild.setup(codelldbPath)
		-- vim.keymap.set("n", "<leader>bd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
		-- vim.keymap.set("n", "<leader>bD", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
		-- vim.keymap.set("n", "<leader>bt", xcodebuild.debug_tests, { desc = "Debug Tests" })
		-- vim.keymap.set("n", "<leader>bC", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
		-- vim.keymap.set("n", "<leader>bb", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		-- vim.keymap.set("n", "<leader>bB", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
		-- vim.keymap.set("n", "<leader>bx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
	end,
}
