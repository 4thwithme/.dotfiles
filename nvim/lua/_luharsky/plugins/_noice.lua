return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = "cmdline",
				opts = {}, -- global options for the cmdline. See section on views
				---@type table<string, CmdlineFormat>
				format = {
					cmdline = { pattern = "^:", icon = "COMMAND: ", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "HELP: >" },
					input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
				},
			},
			views = {
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
				notify = {
					backend = "notify",
					fallback = "mini",
					format = "notify",
					replace = false,
					merge = false,
				},
			},
			notify = {
				enabled = true,
				view = "notify",
			},
		})

		require("notify").setup({
			background_colour = "NotifyBackground",
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
			minimum_width = 50,
			render = "compact",
			stages = "fade_in_slide_out",
			time_formats = {
				notification = "%T",
				notification_history = "%FT%T",
			},
			timeout = 3000,
			top_down = false,
			max_height = function()
				return math.floor(vim.o.lines * 0.2)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.4)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
				vim.wo[win].winhl = "Normal:NotifyNormalFloat"
			end,
		})
	end,
}

