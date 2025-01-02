vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }
vim.g.astro_highlight = 1
vim.g.astro_stylus = "enable"
vim.g.astro_typescript = "enable"

-- disable left side ~ on empty lines
vim.cmd([[set fillchars=eob:\ ]])

vim.g.python3_host_prog = "/Users/andrii/miniconda3/envs/ml/bin/python"

-- Add autocommand to enable highlight for .astro files or buffer New
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.astro",
	command = "TSEnable highlight",
})
vim.filetype.add({
	extension = {
		astro = "astro",
	},
})
-- local function open_nvim_tree()
-- 	-- open the tree
-- 	require("nvim-tree.api").tree.open()
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
