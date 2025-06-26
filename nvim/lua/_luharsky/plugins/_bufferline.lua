return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	init = function()
		-- Set transparent background for tabline and bufferline
		vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineTab", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineTabClose", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineBuffer", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = "NONE" })
	end,
	config = function()
		require("bufferline").setup({
			highlights = {
				fill = { bg = "NONE" },
				background = { bg = "NONE" },
				tab = { bg = "NONE" },
				tab_selected = { bg = "NONE" },
				tab_close = { bg = "NONE" },
				close_button = { bg = "NONE" },
				close_button_visible = { bg = "NONE" },
				close_button_selected = { bg = "NONE" },
				buffer_visible = { bg = "NONE" },
				buffer_selected = { bg = "NONE" },
				separator = { bg = "NONE" },
				separator_visible = { bg = "NONE" },
				separator_selected = { bg = "NONE" },
				indicator_visible = { bg = "NONE" },
				indicator_selected = { bg = "NONE" },
			},
			options = {
				separator_style = "thin",
				custom_filter = function(buf_number, buf_numbers)
					local buf_name = vim.fn.bufname(buf_number)
					return buf_name ~= "claude"
				end,
				diagnostics_indicator = function(count, level)
					local icon = ""
					if level == "error" then
						icon = ""
					elseif level == "warning" then
						icon = ""
					elseif level == "info" then
						icon = ""
					elseif level == "hint" then
						icon = ""
					end

					return " " .. icon .. count
				end,
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				-- offsets = { { filetype = "NvimTree", text = "NVIM TREE", text_align = "center" } },
				offsets = {},
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
				color_icons = true, -- whether or not to add the filetype icon highlights
				show_buffer_icons = false, -- disable filetype icons for buffers
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = true,
				show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
				persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
				move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
				-- can also be a table containing 2 custom separators
				-- [focused and unfocused]. eg: { '|', '|' }
				always_show_bufferline = true,
			},
		})

		-- Persistent transparent background override
		local function set_transparent_highlights()
			vim.cmd([[
			hi! TabLine guibg=NONE ctermbg=NONE
			hi! TabLineFill guibg=NONE ctermbg=NONE
			hi! TabLineSel guibg=NONE ctermbg=NONE
			hi! BufferLineFill guibg=NONE ctermbg=NONE
			hi! BufferLineBackground guibg=NONE ctermbg=NONE
			hi! BufferLineTab guibg=NONE ctermbg=NONE
			hi! BufferLineTabClose guibg=NONE ctermbg=NONE
			hi! BufferLineTabSelected guibg=NONE ctermbg=NONE
			hi! BufferLineBuffer guibg=NONE ctermbg=NONE
			hi! BufferLineBufferSelected guibg=NONE ctermbg=NONE
			hi! BufferLineBufferVisible guibg=NONE ctermbg=NONE
			hi! BufferLineSeparator guibg=NONE ctermbg=NONE
			hi! BufferLineSeparatorSelected guibg=NONE ctermbg=NONE
			hi! BufferLineSeparatorVisible guibg=NONE ctermbg=NONE
		]])
		end

		-- Apply immediately and on colorscheme changes
		set_transparent_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_transparent_highlights,
		})
	end,
}
