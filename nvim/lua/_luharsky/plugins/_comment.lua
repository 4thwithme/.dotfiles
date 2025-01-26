return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = { line = "?", block = "gbc" },
			opleader = { line = "??", block = "gb" },
		})
	end,
	lazy = false,
}
