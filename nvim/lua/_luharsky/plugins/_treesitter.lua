return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			automatic_installation = true,

			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"scss",
				"kdl",
				"astro",
				"toml",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"ruby",
				"vimdoc",
				"python",
				"c",
				"rust",
				"jsonc",
				-- Configuration file formats for .cnf files
				"ini",
			},
		})
	end,
}
