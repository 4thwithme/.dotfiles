local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- common keybindings
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })
keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")
keymap.set("n", "<S-d>", "<C-d>zz")
keymap.set("n", "<S-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "COPY to [COMPUTER] clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "COPY to [VIM] clipboard" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "CUT to [VIM] clipboard" })
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word to new" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy [f]ind [b]uffers" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = " Git [f]iles [s]tatus" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "[f]iles [d]iagnostics" })
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "[f]iles [c]ommits" })

-- oil filesystem
keymap.set("n", "|", "<cmd>Oil --float<CR>", { desc = "[O]il filesystem" })

-- harpoon
keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", { desc = "Harpoon Add" })
keymap.set("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Harpoon Check" })
for i = 1, 9, 1 do
	vim.keymap.set(
		"n",
		"<leader>" .. i,
		":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>",
		{ desc = "Saved file " .. i }
	)
end
-- nvim-tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- bufferline
for i = 1, 9, 1 do
	vim.keymap.set({ "n", "v" }, "<A-" .. i .. ">", ":BufferLineGoToBuffer" .. i .. "<CR>", opts)
end

keymap.set({ "n", "v" }, "<A-.>", ":BufferLineCycleNext<CR>", opts)
keymap.set({ "n", "v" }, "<A-,>", ":BufferLineCyclePrev<CR>", opts)
keymap.set({ "n", "v" }, "<A->>", ":BufferLineMoveNext<CR>", opts)
keymap.set({ "n", "v" }, "<A-<>", ":BufferLineMovePrev<CR>", opts)
keymap.set({ "n", "v" }, "<A-c>", ":BufferLinePickClose<CR>", opts)
keymap.set({ "n", "v" }, "<A-p>", ":BufferLineTogglePin<CR>", opts)

-- undo
keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "[F]iles [U]ndo" })
-- clipboard history
keymap.set({ "n", "v" }, "<leader>fc", ":Telescope neoclip<CR>", { desc = "[F]ind [C]opy items" })
-- diffvew
keymap.set({ "n", "v" }, "<leader>G", ":DiffviewOpen<CR>", opts)
keymap.set({ "n", "v" }, "<leader>CG", ":DiffviewClose<CR>", opts)
-- diagnostics
keymap.set({ "n", "v" }, "<leader>D", ":Trouble diagnostics toggle<CR>", { desc = "[D]iagnostic toggle" })
-- markdown
keymap.set({ "n", "v" }, "<leader>mr", ":MarkdownPreview<CR>", { desc = "[M]arkdown [R]un" })
keymap.set({ "n", "v" }, "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "[M]arkdown [S]top" })
-- copilot
keymap.set({ "n", "v" }, "<leader>coe", ":Copilot enable<CR>", { desc = "[Co]pilot [E]nable" })
keymap.set({ "n", "v" }, "<leader>cod", ":Copilot disable<CR>", { desc = "[Co]pilot [D]isable" })
-- copilot chat
keymap.set({ "n", "v" }, "<leader>cct", ":CopilotChatToggle<CR>", { desc = "[Co]pilot [C]hat [T]oggle" })
keymap.set({ "n", "v" }, "<leader>ccr", ":CopilotChatReset<CR>", { desc = "[Co]pilot [C]hat [R]eset" })
keymap.set({ "n", "v" }, "<leader>cce", ":CopilotChatExplain<CR>", { desc = "[Co]pilot [C]hat [E]xplain" })
keymap.set({ "n", "v" }, "<leader>ccf", ":CopilotChatFix<CR>", { desc = "[Co]pilot [C]hat [F]ix" })
keymap.set({ "n", "v" }, "<leader>ccl", ":CopilotChatLoad<CR>", { desc = "[Co]pilot [C]hat [L]oad" })
keymap.set({ "n", "v" }, "<leader>ccs", ":CopilotChatSave<CR>", { desc = "[Co]pilot [C]hat [S]ave" })
-- cloak
keymap.set({ "n", "v" }, "<leader>env", ":CloakToggle<CR>", { desc = "[ENV]" })
-- replace all 
keymap.set(
	"v",
	"<leader>ra",
	":lua visual_find_replace()<CR>",
	{ noremap = true, silent = true, desc = "Find and replace selected text" }
)
