return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local keymap = vim.keymap

		vim.lsp.enable("astro")
		vim.lsp.enable("ruby_lsp")
		vim.lsp.enable("graphql")
		vim.lsp.enable("emmet_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("prismals")

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

				vim.keymap.set("n", "ds", function()
					local new_config = vim.diagnostic.config().virtual_lines
					if new_config then
						new_config = false
					else
						new_config = { current_line = true }
					end

					vim.diagnostic.config({ virtual_lines = new_config })
				end, { desc = "Toggle diagnostic virtual_lines for current line" })
			end,
		})

		vim.diagnostic.config({
			underline = true,

			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = "󰠠 ",
					[vim.diagnostic.severity.HINT] = " ",
				},
				numhl = {
					[vim.diagnostic.severity.WARN] = "WarningMsg",
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.INFO] = "Normal",
					[vim.diagnostic.severity.HINT] = "HintMsg",
				},
			},
		})
	end,
}
