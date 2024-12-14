return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 30, -- how many suggestions should be shown in the list?
		},
		win = {
			border = "double", -- none, single, double, shadow
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			zindex = 1000, -- positive value to position WhichKey above other floating windows.
		},
		-- layout = {
		-- 	height = { min = 8, max = 25 }, -- min and max height of the columns
		-- 	width = { min = 20, max = 40 }, -- min and max width of the columns
		-- 	spacing = 6, -- spacing between columns
		-- 	align = "left", -- align columns left, center or right
		-- },
	},
}
