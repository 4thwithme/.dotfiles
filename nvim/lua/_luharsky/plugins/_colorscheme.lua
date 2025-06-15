return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
					keywords = { bold = true },
					functions = { bold = true },
					constant = { bold = true },
				},
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = true,
	-- 				transparency = true,
	-- 			},
	-- 			highlight_groups = {
	-- 				keyword = { bold = true },
	-- 				functions = { bold = true },
	-- 				constants = { bold = true },
	-- 			},
	-- 		})
	-- 		vim.cmd([[colorscheme rose-pine]])
	-- 	end,
	-- },
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").setup({
	-- 			transparent = {
	-- 				bg = true,
	-- 				float = true,
	-- 			},
	-- 		})
	--
	-- 		vim.cmd([[colorscheme nordic]])
	-- 	end,
	-- },
	-- {
	-- 	"4thwithme/black.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("black").setup({
	-- 			-- style = "dark",
	-- 			-- transparent = true,
	-- 			-- styles = {
	-- 			-- 	sidebars = "transparent",
	-- 			-- 	floats = "transparent",
	-- 			-- },
	-- 		})
	-- 		vim.cmd([[colorscheme black]])
	-- 	end,
	-- },
}
