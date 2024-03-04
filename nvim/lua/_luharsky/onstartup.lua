vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.astro_typescript = 'enable'
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }
require("nvim-treesitter.install").prefer_git = true
vim.cmd([[colorscheme catppuccin]])
-- vim.cmd([[colorscheme black]]);

-- disable vim bottom statusline
vim.cmd([[set laststatus=0]])
-- disable vim mode
vim.cmd([[set noshowmode]])
-- disable left side ~ on empty lines
vim.cmd([[set fillchars=eob:\ ]])
