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
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts, { desc = '[g]o to [r]eference' })
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = '[g]o to [d]eclaration' })
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts, { desc = '[g]o to [d]efinition' })
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts, { desc = '[g]o to [i]mplementation' })
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts, { desc  '[g]o to [t]ype [d]efinitions'})
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts, { desc = 'see [A]vailable [A]ctions'})
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = '[R]e[n]ame'})
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts, { desc= "[D]iagnostics" })
        keymap.set("n", "K", vim.lsp.buf.hover, opts, { desc = "See Documentation"})
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- TODO: diagnostics, format on save, ts, prsiam servers

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities, 
          settings = {
            Lua = {
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
