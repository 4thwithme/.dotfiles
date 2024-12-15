return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "tokyonight",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = false,
				globalstatus = true,
				refresh = {},
			},
			sections = {},
			inactive_sections = {},
			tabline = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						function()
							local unsaved = 0
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								if vim.api.nvim_buf_get_option(buf, "modified") then
									unsaved = unsaved + 1
								end
							end

							if unsaved == 0 then
								return ""
							else
								return unsaved .. " UNSAVED"
							end
						end,
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						"buffers",
						mode = 2,
						use_mode_colors = true,
						buffer_max_length = 40,
						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
						fmt = function(name)
							if #name > 20 then
								return string.sub(name, 1, 17) .. "..."
							end
							return name
						end,
					},
				},
				lualine_z = { "location" },
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
