vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.astro_typescript = 'enable'
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }
vim.cmd([[colorscheme catppuccin]])
-- vim.cmd([[colorscheme black]]);
-- vim.cmd([[colorscheme everforest]]);
require("nvim-treesitter.install").prefer_git = true
