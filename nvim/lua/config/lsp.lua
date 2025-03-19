local function goto_diagnostic(d)
	vim.api.nvim_set_current_buf(d.bufnr)
	vim.api.nvim_win_set_cursor(0, { d.lnum + 1, d.col })
	-- wait for the cursor to move
	vim.defer_fn(function()
		vim.diagnostic.open_float(d)
	end, 10)
end

local function goto_next_diagnostic_global()
	local diagnostics = vim.diagnostic.get(nil) -- Get all diagnostics in all buffers
	if #diagnostics == 0 then
		return
	end

	table.sort(diagnostics, function(a, b)
		return a.lnum < b.lnum or (a.lnum == b.lnum and a.col < b.col)
	end)

	local pos = vim.api.nvim_win_get_cursor(0)
	local bufnr = vim.api.nvim_get_current_buf()

	for _, d in ipairs(diagnostics) do
		if
			d.bufnr > bufnr or (d.bufnr == bufnr and (d.lnum > pos[1] - 1 or (d.lnum == pos[1] - 1 and d.col > pos[2])))
		then
			goto_diagnostic(d)
			return
		end
	end
	goto_diagnostic(diagnostics[1])
end

local function goto_prev_diagnostic_global()
	local diagnostics = vim.diagnostic.get(nil) -- Get all diagnostics in all buffers
	if #diagnostics == 0 then
		return
	end

	table.sort(diagnostics, function(a, b)
		return a.lnum > b.lnum or (a.lnum == b.lnum and a.col > b.col)
	end)

	local pos = vim.api.nvim_win_get_cursor(0)
	local bufnr = vim.api.nvim_get_current_buf()

	for _, d in ipairs(diagnostics) do
		if
			d.bufnr < bufnr or (d.bufnr == bufnr and (d.lnum < pos[1] - 1 or (d.lnum == pos[1] - 1 and d.col < pos[2])))
		then
			goto_diagnostic(d)
			return
		end
	end
	goto_diagnostic(diagnostics[1])
end

local augroup = vim.api.nvim_create_augroup
local VimScientistGroup = augroup("VimScientist", {})
local autocmd = vim.api.nvim_create_autocmd

local function buildProject()
	-- local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	-- get current filetype of current buffer
	local filetype = vim.bo.filetype

	if filetype == "swift" then
		vim.cmd("!swift build")
	end
end

autocmd("LspAttach", {
	group = VimScientistGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>lr", function()
			buildProject()
			vim.cmd("LspRestart")
		end, opts)
		vim.keymap.set("n", "[d", goto_next_diagnostic_global, { desc = "Go to next diagnostic in project" })
		vim.keymap.set("n", "]d", goto_prev_diagnostic_global, { desc = "Go to previous diagnostic in project" })
		vim.keymap.set("n", "<leader>vq", function()
			vim.diagnostic.setqflist()
		end, opts)
	end,
})
