return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night",
	-- 			-- transparent = true,
	-- 			styles = {
	-- 				-- sidebars = "transparent",
	-- 				-- floats = "transparent",
	-- 			},
	-- 		})
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({})

			vim.cmd([[colorscheme nordic]])
		end,
	},
}
