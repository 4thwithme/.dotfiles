return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			float = {
				padding = 4,
				border = "double",
			},
			delete_to_trash = true,
			watch_for_changes = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})
	end,
}
