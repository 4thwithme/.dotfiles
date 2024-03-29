local mark = require('harpoon.mark');
local ui = require('harpoon.ui');
local conf = require("telescope.config").values
local builtin = require('telescope.builtin')

local opts = { noremap = true, silent = true }

-- common keybindings
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv");
vim.keymap.set("n", "<S-d>", "<C-d>zz")
vim.keymap.set("n", "<S-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "COPY to buffer" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "COPY to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "CUT to clipboard" })
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz");
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz");
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz");
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz");
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word to new" });
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- show type definition on hover lspsaga
vim.keymap.set("n", "L", ":Lspsaga peek_type_definition<CR>", opts, { desc = "Show type definition on hover" });

-- harpoon keybindings
vim.keymap.set('n', '<leader>a', mark.add_file, { desc = "Harpoon Add" });
vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = "Harpoon Check" });
for i = 1, 9, 1 do vim.keymap.set('n', '<leader>' .. i, function() ui.nav_file(i) end, { desc = "Saved file " .. i }); end;

-- telescope
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').git_status, { desc = ' Git [f]iles [s]tatus' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = ' [f]ind recently [o]pened files' })
vim.keymap.set('n', '<leader>fh', ":Telescope harpoon marks<cr>", { desc = ' [f]ind recently [o]pened files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]ile' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
-- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'search in [f]iles by [g]rep' })
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = 'search in [f]iles by [g]rep with args' })

vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[f]iles [d]iagnostics' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').git_branches, { desc = '[f]iles [b]ranches' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').git_commits, { desc = '[f]iles [c]ommits' })

-- gitfugitive

vim.keymap.set('n', '/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, opts, { desc = '[/] Fuzzily search in current buffer' })

-- undo
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = '[F]iles [U]ndo' })
-- file browser
vim.api.nvim_set_keymap("n", "|",
  ":Telescope file_browser path=%:p:h select_buffer=true prompt_path=true grouped=true git_status=true hidden=true<CR>",
  { noremap = true })
-- clipboard history
vim.keymap.set({ "n", "v" }, "<leader>fc", ":Telescope neoclip<CR>", { desc = '[F]ind [C]opy items' }, { noremap = true });
-- diffvew
vim.keymap.set({ 'n', 'v' }, "<leader>G", ":DiffviewOpen<CR>", opts);
vim.keymap.set({ 'n', 'v' }, "<leader>CG", ":DiffviewClose<CR>", opts);
-- diagnostics
vim.keymap.set({ 'n', 'v' }, "<leader>D", ":TroubleToggle<CR>", opts, { desc = "[D]iagnostic toggle" })
-- markdown
vim.keymap.set({ 'n', 'v' }, "<leader>mr", ":MarkdownPreview<CR>", opts, { desc = "[M]arkdown [R]un" });
vim.keymap.set({ 'n', 'v' }, "<leader>ms", ":MarkdownPreviewStop<CR>", opts, { desc = "[M]arkdown [S]top" });
-- copilot
vim.keymap.set({ 'n', 'v' }, "<leader>coe", ":Copilot enable<CR>", opts, { desc = "[Co]pilot [E]nable" });
vim.keymap.set({ 'n', 'v' }, "<leader>cod", ":Copilot disable<CR>", opts, { desc = "[Co]pilot [D]isable" });
-- cloak
vim.keymap.set({ 'n', 'v' }, "<leader>env", ":CloakToggle<CR>", opts, { desc = "[ENV]" });
