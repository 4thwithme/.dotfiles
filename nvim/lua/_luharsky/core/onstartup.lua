-- ===================================================================
-- PLUGIN-SPECIFIC CONFIGURATIONS
-- ===================================================================

-- Copilot Configuration
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }

-- Astro Framework Support
vim.g.astro_highlight = 1
vim.g.astro_stylus = "enable"
vim.g.astro_typescript = "enable"

-- ===================================================================
-- UI IMPROVEMENTS
-- ===================================================================

-- Hide ~ symbols on empty lines
vim.cmd([[set fillchars=eob:\ ]])

-- ===================================================================
-- FILETYPE CONFIGURATIONS
-- ===================================================================

-- Astro file handling
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.astro",
	command = "TSEnable highlight",
	desc = "Enable TreeSitter highlighting for Astro files",
})

vim.filetype.add({
	extension = {
		astro = "astro",
	},
})
