return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
    separator_style = "thin",
    mode = "buffers", -- set to "tabs" to only show tabpages instead
		themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
		numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		indicator = {
			icon = '▎', -- this should be omitted if indicator style is not 'icon'
			style = "icon" --'icon' | 'underline' | 'none',
		},
    offsets = {{filetype = "NvimTree", text = "NVIM TREE", text_align = "center"}},
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		color_icons = true,     -- whether or not to add the filetype icon highlights
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
	  	always_show_bufferline = true,
    },
  },
}
