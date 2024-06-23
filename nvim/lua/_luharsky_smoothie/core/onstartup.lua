vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { markdown = true }
vim.g.astro_typescript = "enable"
local function open_nvim_tree()
	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- disable left side ~ on empty lines
vim.cmd([[set fillchars=eob:\ ]])
