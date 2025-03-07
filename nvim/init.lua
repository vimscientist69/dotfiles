require("remap")
require("config.lazy")
require("config.lsp")
require("set")

vim.cmd([[colorscheme tokyonight-night]])

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.neovide_padding_top = 50
vim.g.neovide_padding_bottom = 50
vim.g.neovide_padding_right = 50
vim.g.neovide_padding_left = 50

-- set WinSeparator highlight color
vim.cmd([[highlight WinSeparator guifg=#ffffff]])
