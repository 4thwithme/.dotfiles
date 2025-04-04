return {
	{
		"4thwithme/ss.nvim",
		name = "ss.nvim",
		lazy = false,
		dependencies = {
			"mikew/nvim-drawer",
		},
		config = function()
			require("sidebar").setup({
				width = 60,
				side = "right",
				auto_close = false,
				border = "single",
				title = "Search Sidebar",
			})

			vim.keymap.set("n", "<leader>S", "<cmd>SidebarToggle<CR>", { desc = "Toggle Sidebar" })
		end,
	},
}
