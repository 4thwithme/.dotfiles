return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local previewers = require("telescope.previewers")

		local actions = require("telescope.actions")

		telescope.load_extension("undo")

		local _bad = {
			".*%.csv",
			".*%.lock",
			".*%.env",
			".*%.env.*",
			".log.*",
		}

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
				border = true,
				borderchars = {
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},

				path_display = { "smart" },
				file_ignore_patterns = {
					"node_modules/.*",
					"build/.*",
					"dist/.*",
					".git/.*",
					".cache/.*",
					"%.lock",
				},

				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_cutoff = 120,
						preview_width = 0.35,
						results_width = 0.6,
					},
					width = 0.99,
				},
				winblend = 0,
				buffer_previewer_maker = new_maker,
				mappings = {
					i = {
						["<A-c>"] = actions.delete_buffer + actions.move_to_top,
					},
					n = {
						["<A-c>"] = actions.delete_buffer + actions.move_to_top,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob=!node_modules/",
						"--glob=!build/",
						"--glob=!dist/",
						"--glob=!.git/",
						"--glob=!.cache/",
					},
				},
				live_grep = {
					additional_args = function()
						return {
							"--glob=!node_modules/",
							"--glob=!build/",
							"--glob=!dist/",
							"--glob=!.git/",
							"--glob=!.cache/",
							"--glob=!.vscode/",
							"--glob=!*.lock",
							"--glob=!*.csv",
							"--glob=!*-lock.json",
						}
					end,
				},
			},
			extensions = {
				undo = {
					use_delta = true,
					side_by_side = true,
					diff_context_lines = vim.o.scrolloff,
					entry_format = "state #$ID, $STAT, $TIME",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.8,
						},
						width = 0.99,
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
		})
	end,
}
