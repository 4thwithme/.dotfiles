return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local WIDTH_RATIO = 0.3 -- You can change this too

		nvimtree.setup({
			view = {
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			live_filter = {
				prefix = ":",
				always_show_folders = false, -- Turn into false from true by default
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = {
					-- "node_modules/.*",
					".DS_Store",
				},
			},
			git = {
				ignore = false,
			},
		})
	end,
}
