return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { remap = false, silent = true, buffer = ev.buf }
				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				opts.desc = "Go to declaration" -- go to declaration
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				opts.desc = "Show LSP definitions" -- show lsp definitions
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				opts.desc = "Show LSP implementations" -- show lsp implementations
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				opts.desc = "Show LSP type definitions" -- show lsp type definitions
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				opts.desc = "See available code actions" -- see available code actions, in visual mode will apply to selection
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				opts.desc = "Smart rename" -- smart rename
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				opts.desc = "Show buffer diagnostics" -- show  diagnostics for file
				keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				opts.desc = "Show documentation for what is under cursor" -- show documentation for what is under cursor
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				opts.desc = "Restart LSP" -- mapping to restart lsp if necessary
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		vim.diagnostic.config({
			underline = true,
			virtual_text = false,
			severity_sort = true,
			float = { source = "always" },
			update_in_insert = false,
		})

		-----
		local on_attach = function(_, bufnr)
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "single",
						source = "always",
						prefix = "- ",
						scope = "cursor",
					})
				end,
			})
		end

		vim.diagnostic.config({
			underline = true,
			virtual_text = false,
			severity_sort = true,
			float = { source = "always" },
			update_in_insert = false,
		})

		-----

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["ruby_lsp"] = function()
				lspconfig.ruby_lsp.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						ruby_lsp = {
							diagnostics = true,
							suggest = true,
							completion = true,
							hover = true,
						},
					},
				})
			end,
			["astro"] = function()
				lspconfig.astro.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "astro" },
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["pyright"] = function()
				lspconfig["pyright"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					before_init = function(params, config)
						local util = require("lspconfig.util")
						local path = util.path

						local default_venv_path = path.join(vim.env.HOME, "miniconda3", "envs", "ml", "bin", "python")
						print("Setting python path to: " .. default_venv_path)
						config.settings.python.pythonPath = default_venv_path
					end,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
