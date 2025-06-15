return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			outline = {
				win_position = "right",
				win_width = 42,
				auto_preview = false,
				left_width = 0.2,
				detail = false,
			},
		})

		vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "LSP Outline" })
	end,
}
