vim.o.guicursor = ""
vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.syntax = "ON"
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true
vim.o.scrolloff = 8

vim.o.inccommand = "split"
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = "yes"

vim.g.vimwiki_folding = "custom"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "manual"
vim.o.laststatus = 3
