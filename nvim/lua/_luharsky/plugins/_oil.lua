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
				padding = 2,
				width = 0.8,
				height = 80,
				max_height = 80,
				border = "single",
				win_options = {
					winblend = 0,
				},
				override = function(conf)
					return conf
				end,
			},
			delete_to_trash = true,
			watch_for_changes = true,
			keymaps = {
				["|"] = { "<cmd>Oil --float<cr>", mode = "n" },
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})
	end,
}
