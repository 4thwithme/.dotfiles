vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }
vim.g.astro_highlight = 1
vim.g.astro_stylus = "enable"
vim.g.astro_typescript = "enable"

-- disable left side ~ on empty lines
vim.cmd([[set fillchars=eob:\ ]])

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.astro",
	command = "TSEnable highlight",
})
vim.filetype.add({
	extension = {
		astro = "astro",
	},
})
