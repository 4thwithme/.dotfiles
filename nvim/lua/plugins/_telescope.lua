return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'debugloop/telescope-undo.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },

  },

  config = function()
    local telescope = require("telescope");
    local fb_actions = require("telescope._extensions.file_browser.actions");
    local trouble = require("trouble.providers.telescope");
    local previewers = require("telescope.previewers");


    telescope.load_extension("file_browser")
    telescope.load_extension('undo')
    telescope.load_extension('harpoon')
    telescope.load_extension('ui-select')
    telescope.load_extension("live_grep_args")

    local _bad = { ".*%.csv", ".env", ".env.*%", '.*%.lock' }
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
        layout_strategy = "horizontal",
        buffer_previewer_maker = new_maker,
        sorting_strategy = "ascending",
        vimgrep_arguments = { 'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number',
          '--column', '--smart-case', '--ignore-file',
          '.gitignore' },
        winblend = 0,
        mappings = {
          i = { ["<C-h>"] = "which_key", ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
        layout_config = {
          width = 0.8,
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        }, --Block-comment keymap
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
        file_browser = {
          hijack_netrw = false,
          use_fd = true,
          prompt_path = false,
          hidden = false,
          collapse_dirs = false,
          grouped = true,
          display_stat = { date = true, size = true },
          git_status = true,
          mappings = {
            ["i"] = {
              ["<A-c>"] = fb_actions.create,
              ["<S-CR>"] = fb_actions.create_from_prompt,
              ["<A-r>"] = fb_actions.rename,
              ["<A-m>"] = fb_actions.move,
              ["<A-y>"] = fb_actions.copy,
              ["<A-d>"] = fb_actions.remove,
              ["<C-o>"] = fb_actions.open,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.goto_home_dir,
              ["<C-w>"] = fb_actions.goto_cwd,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            ["n"] = {
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["o"] = fb_actions.open,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
        },
      }
    });
  end,
};
