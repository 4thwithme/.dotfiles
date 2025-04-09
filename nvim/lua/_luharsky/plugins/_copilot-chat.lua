return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "github/copilot.vim" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},

		config = function()
			require("CopilotChat").setup({
				model = "claude-3.7-sonnet-thought",
				-- context = { "#files: **/*" },
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 0.4, -- fractional width of parent, or absolute width in columns when > 1
				},
				question_header = "=== User ===", -- Header to use for user questions
				answer_header = "=== Github Copilot ===", -- Header to use for AI answers
				error_header = "=== Error ===", -- Header to use for errors
				separator = "───", -- Separator to use in chat
			})
		end,
	},
}
