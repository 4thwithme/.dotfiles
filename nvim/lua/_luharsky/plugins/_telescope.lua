return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local previewers = require("telescope.previewers")

		telescope.load_extension("undo")

		local _bad = { ".*%.csv", ".env", ".env.*%", ".*%.lock" }
		local bad_files = function(filepath)
			for _, v in ipairs(_bad) do
				if filepath:match(v) then
					return true
				end
			end

			return false
		end

		local new_maker = function(filepath, bufnr, opts)
			opts = opts or {}
			if bad_files(filepath) == true then
				return
			else
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			end
		end

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--ignore-file",
					".gitignore",
				},
				winblend = 0,
				buffer_previewer_maker = new_maker,
				mappings = {},
				extensions = {
					undo = {
						use_delta = true,
						side_by_side = true,
						diff_context_lines = vim.o.scrolloff,
						entry_format = "state #$ID, $STAT, $TIME",
						layout_strategy = "horizontal",
						width = 0.9,
						layout_config = {
							preview_width = 0.8,
						},
						mappings = {
							n = {
								["a"] = require("telescope-undo.actions").yank_additions,
								["d"] = require("telescope-undo.actions").yank_deletions,
								["<cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
