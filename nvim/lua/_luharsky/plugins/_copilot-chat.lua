return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},

		config = function()
			require("CopilotChat").setup({
				window = {
					layout = "float",
					relative = "cursor",
					width = 0.8,
					height = 0.8,
					row = 1,
				},
				show_help = false,
			})
		end,
	},
}
