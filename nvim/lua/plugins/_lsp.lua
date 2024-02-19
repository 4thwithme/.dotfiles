return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'onsails/lspkind.nvim', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer', 'hrsh7th/vim-vsnip', 'hrsh7th/cmp-vsnip' },
  config = function()
    local lspconfig = require('lspconfig');
    local lsp_zero = require('lsp-zero').preset({})
    local capabilities = require("cmp_nvim_lsp").default_capabilities();
    local cmp = require('cmp');

    lsp_zero.preset("recommended");

    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

    local on_attach_mappings = function(_, bufnr)
      local opts = { remap = false, silent = true, buffer = bufnr }

      vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts, { desc = '[g]o to [d]eclaration' });
      vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts, { desc = '[g]o to [d]efinition' });
      vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts, { desc = 'show [k]ind' });
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts, { desc = '[g]o to [i]mplementation' });
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.reference()<CR>', opts, { desc = '[g]o to [r]eference' });
      vim.keymap.set('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts, { desc = '[g]o to [a]ction' });
      vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts, { desc = '[r]ename' });
      vim.keymap.set('n', 'gS', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts, { desc = '[g]o to [s]ignature' });
      vim.keymap.set('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts,
        { desc = '[g]o to [t]ype definition' });
    end;

    local on_cursor_hold = function()
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'single',
            source = 'always',
            prefix = '- ',
            scope = 'cursor',
          })
        end
      })
    end;

    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
      severity_sort = true,
      float = { source = "always" },
      update_in_insert = false,
      signs = {
        error = { text = "E" },
        warning = { text = "W" },
        hint = { text = "H" },
        information = { text = "I" },
      }
    });

    local cmp_mappings = lsp_zero.defaults.cmp_mappings({
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<cr>"] = cmp.mapping.confirm({ select = true }),
      ["<C-c>"] = cmp.mapping.complete(),
      ["<Esc>"] = cmp.mapping.close(),
    });


    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp_mappings
    })
    -- need to install manually
    -- npm install -g @prisma/language-server
    -- npm install -g typescript-language-server typescript
    -- install rust_analizer manually
    -- npm i -g vscode-langservers-extracted
    lsp_zero.setup_servers({ 'rust_analyzer', 'tsserver', 'eslint', 'astro', 'lua_ls', 'prismals', })

    lsp_zero.on_attach(function(client, bufnr)
      on_attach_mappings(client, bufnr);
      on_cursor_hold();

      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<Leader>lf", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })

        -- format on save
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = false })
          end,
          desc = "[lsp] format on save",
        })
      end;
    end);

    lsp_zero.setup();

    -- server's setup

    lspconfig.tsserver.setup({
      on_attach = function(client, bufnr)
        on_attach_mappings(client, bufnr);
        on_cursor_hold();

        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.cmd(":PrettierAsync<CR>");
          end,
          desc = "[lsp] format on save",
        });
      end,
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = true
        }
      }
    });

    lspconfig.rust_analyzer.setup({
      on_attach = (function(client)
        require('completion').on_attach(client)
      end),
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
        }
      }
    });

    lspconfig.astro.setup({
      on_attach = (function(client)
        require 'completion'.on_attach(client)
      end)
    });

    lspconfig.eslint.setup({
      on_attach = (function(client)
        require 'completion'.on_attach(client)
      end)
    });
  end,
}
