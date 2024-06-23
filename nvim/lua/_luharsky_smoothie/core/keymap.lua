local keymap = vim.keymap;
local opts = { noremap = true, silent = true }

vim.g.mapleader = " ";
-- local mark = require('harpoon.mark');
-- local ui = require('harpoon.ui');
-- local conf = require("telescope.config").values
-- local builtin = require('telescope.builtin')

-- common keybindings
keymap.set("n", "+", "<C-a>",  { desc = "Increment number" })
keymap.set("n", "-", "<C-x>",  { desc = "Decrement number" })
keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv");
keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv");
keymap.set("n", "<S-d>", "<C-d>zz")
keymap.set("n", "<S-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "COPY to [COMPUTER] clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "COPY to [VIM] clipboard" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "CUT to [VIM] clipboard" })
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word to new" });
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set('n', '<leader>fs', "<cmd>Telescope git_status<cr>", { desc = ' Git [f]iles [s]tatus' })
keymap.set('n', '<leader>fd', "<cmd>Telescope diagnostics<cr>", { desc = '[f]iles [d]iagnostics' })
keymap.set('n', '<leader>fb', "<cmd>Telescope git_branches<cr>", { desc = '[f]iles [b]ranches' })
keymap.set('n', '<leader>fc', "<cmd>Telescope git_commits<cr>", { desc = '[f]iles [c]ommits' })



-- show type definition on hover lspsaga
-- vim.keymap.set("n", "L", ":Lspsaga peek_type_definition<CR>", opts, { desc = "Show type definition on hover" });

-- TODO:  kharpoon eybindings
-- keymap.set('n', '<leader>a', mark.add_file, { desc = "Harpoon Add" });
-- keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = "Harpoon Check" });
-- for i = 1, 9, 1 do vim.keymap.set('n', '<leader>' .. i, function() ui.nav_file(i) end, { desc = "Saved file " .. i }); end;

-- telescope
-- keymap.set('n', '<leader>fh', ":Telescope harpoon marks<cr>", { desc = ' [f]ind recently [o]pened files' })
--  { desc = 'search in [f]iles by [g]rep with args' })


-- nvim-tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- bufferline
for i = 1, 9, 1 do vim.keymap.set({ "n", "v" }, "<A-" .. i .. ">", ":BufferLineGoToBuffer " .. i .. "<CR>", opts) end
keymap.set({ "n", "v" }, "<A-.>", ":BufferLineCycleNext<CR>", opts)
keymap.set({ "n", "v" }, "<A-,>", ":BufferLineCyclePrev<CR>", opts)
keymap.set({ "n", "v" }, "<A->>", ":BufferLineMoveNext<CR>", opts)
keymap.set({ "n", "v" }, "<A-<>", ":BufferLineMovePrev<CR>", opts)
keymap.set({ "n", "v" }, "<A-c>", ":BufferLinePickClose<CR>", opts)
keymap.set({ "n", "v" }, "<A-p>", ":BufferLineTogglePin<CR>", opts)

-- gitfugitive

-- undo
-- keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = '[F]iles [U]ndo' })
-- file browser
-- api.nvim_set_keymap("n", "|",
--  ":Telescope file_browser path=%:p:h select_buffer=true prompt_path=true grouped=true git_status=true hidden=true<CR>",
--  { noremap = true })
-- clipboard history
-- keymap.set({ "n", "v" }, "<leader>fc", ":Telescope neoclip<CR>", { desc = '[F]ind [C]opy items' }, { noremap = true });
-- diffvew
--keymap.set({ 'n', 'v' }, "<leader>G", ":DiffviewOpen<CR>", opts);
--keymap.set({ 'n', 'v' }, "<leader>CG", ":DiffviewClose<CR>", opts);
-- diagnostics
keymap.set({ 'n', 'v' }, "<leader>D", "<cmd>TroubleToggle<CR>", opts, { desc = "[D]iagnostic toggle" })
-- markdown
--keymap.set({ 'n', 'v' }, "<leader>mr", ":MarkdownPreview<CR>", opts, { desc = "[M]arkdown [R]un" });
--keymap.set({ 'n', 'v' }, "<leader>ms", ":MarkdownPreviewStop<CR>", opts, { desc = "[M]arkdown [S]top" });
-- copilot
-- keymap.set({ 'n', 'v' }, "<leader>coe", ":Copilot enable<CR>", opts, { desc = "[Co]pilot [E]nable" });
-- keymap.set({ 'n', 'v' }, "<leader>cod", ":Copilot disable<CR>", opts, { desc = "[Co]pilot [D]isable" });
-- cloak
-- keymap.set({ 'n', 'v' }, "<leader>env", ":CloakToggle<CR>", opts, { desc = "[ENV]" });
