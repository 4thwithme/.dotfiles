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
			-- don't allow the popup to overlap with the cursor
			no_overlap = true,
			-- width = 1,
			-- height = { min = 4, max = 25 },
			-- col = 0,
			-- row = math.huge,
			border = "double",
			padding = { 2, 2 }, -- extra window padding [top/bottom, right/left]
			title = false,
			zindex = 1000,
			-- Additional vim.wo and vim.bo options
			bo = {},
			wo = {
				-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
		layout = {
			height = { min = 8, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 40 }, -- min and max width of the columns
			spacing = 6, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
	},
}
