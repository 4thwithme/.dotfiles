return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = {
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"rust_analyzer",
				"astro",
				"prismals",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			automatic_enable = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "eslint_d", -- js linter
				"eslint",
				"isort",
				"black",
			},
		})
	end,
}
