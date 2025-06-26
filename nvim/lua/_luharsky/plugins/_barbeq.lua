return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	init = function()
		-- Set WinBar highlight to transparent before plugin loads
		vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
	end,
	config = function()
		require("barbecue").setup({
			exclude_filetypes = { "netrw", "toggleterm" },
		})
		
		-- Persistent transparent background override
		local function set_transparent_highlights()
			vim.cmd([[
				hi! WinBar guibg=NONE ctermbg=NONE
				hi! WinBarNC guibg=NONE ctermbg=NONE
				hi! link barbecue_normal WinBar
			]])
		end
		
		-- Apply immediately and on colorscheme changes
		set_transparent_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_transparent_highlights,
		})
		
		require("barbecue.ui").toggle(true)
	end,
}
