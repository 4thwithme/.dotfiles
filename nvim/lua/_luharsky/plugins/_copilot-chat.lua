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
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 50, -- fractional width of parent, or absolute width in columns when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "double", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},
			})
		end,
	},
}
