local keymap = vim.keymap

vim.g.mapleader = " "

-- ===================================================================
-- CORE NAVIGATION & EDITING
-- ===================================================================
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })
keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap.set("n", "<S-d>", "<C-d>zz", { desc = "Half page down (centered)" })
keymap.set("n", "<S-u>", "<C-u>zz", { desc = "Half page up (centered)" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- ===================================================================
-- CLIPBOARD OPERATIONS
-- ===================================================================
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- ===================================================================
-- SEARCH & REPLACE
-- ===================================================================
keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)
keymap.set("v", "<leader>ra", ":lua visual_find_replace()<CR>", { desc = "Find and replace selected text" })

-- ===================================================================
-- FILE NAVIGATION (TELESCOPE)
-- ===================================================================
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Undo history" })
keymap.set({ "n", "v" }, "<leader>fcc", ":Telescope neoclip<CR>", { desc = "Clipboard history" })

-- ===================================================================
-- FILE EXPLORERS
-- ===================================================================
keymap.set("n", "|", "<cmd>Oil --float<CR>", { desc = "Oil filesystem" })
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file in explorer" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- ===================================================================
-- HARPOON (QUICK FILE ACCESS)
-- ===================================================================
keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", { desc = "Harpoon add file" })
keymap.set("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Harpoon menu" })
for i = 1, 9 do
	keymap.set(
		"n",
		"<leader>" .. i,
		":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>",
		{ desc = "Harpoon file " .. i }
	)
end

-- ===================================================================
-- BUFFER MANAGEMENT
-- ===================================================================
for i = 1, 9 do
	keymap.set(
		{ "n", "v" },
		"<A-" .. i .. ">",
		":BufferLineGoToBuffer" .. i .. "<CR>",
		{ desc = "Go to buffer " .. i, silent = true }
	)
end
keymap.set({ "n", "v" }, "<A-.>", ":BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
keymap.set({ "n", "v" }, "<A-,>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })
keymap.set({ "n", "v" }, "<A->>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right", silent = true })
keymap.set({ "n", "v" }, "<A-<>", ":BufferLineMovePrev<CR>", { desc = "Move buffer left", silent = true })
keymap.set({ "n", "v" }, "<A-c>", ":BufferLinePickClose<CR>", { desc = "Close buffer", silent = true })
keymap.set({ "n", "v" }, "<A-p>", ":BufferLineTogglePin<CR>", { desc = "Pin buffer", silent = true })

-- ===================================================================
-- GIT OPERATIONS
-- ===================================================================
keymap.set({ "n", "v" }, "<leader>G", ":DiffviewOpen<CR>", { desc = "Open git diff", silent = true })
keymap.set({ "n", "v" }, "<leader>CG", ":DiffviewClose<CR>", { desc = "Close git diff", silent = true })

-- ===================================================================
-- DIAGNOSTICS & DEBUGGING
-- ===================================================================
keymap.set({ "n", "v" }, "<leader>D", ":Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })

-- ===================================================================
-- MARKDOWN
-- ===================================================================
keymap.set({ "n", "v" }, "<leader>mr", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
keymap.set({ "n", "v" }, "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })

-- ===================================================================
-- AI ASSISTANCE
-- ===================================================================
-- Copilot
keymap.set({ "n", "v" }, "<leader>coe", ":Copilot enable<CR>", { desc = "Enable Copilot" })
keymap.set({ "n", "v" }, "<leader>cod", ":Copilot disable<CR>", { desc = "Disable Copilot" })

-- Copilot Chat
keymap.set({ "n", "v" }, "<leader>cct", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
keymap.set({ "n", "v" }, "<leader>ccr", ":CopilotChatReset<CR>", { desc = "Reset Copilot Chat" })
keymap.set({ "n", "v" }, "<leader>cce", ":CopilotChatExplain<CR>", { desc = "Copilot explain" })
keymap.set({ "n", "v" }, "<leader>ccf", ":CopilotChatFix<CR>", { desc = "Copilot fix" })
keymap.set({ "n", "v" }, "<leader>ccl", ":CopilotChatLoad<CR>", { desc = "Copilot load session" })
keymap.set({ "n", "v" }, "<leader>ccs", ":CopilotChatSave<CR>", { desc = "Copilot save session" })

-- ===================================================================
-- UTILITIES
-- ===================================================================
keymap.set({ "n", "v" }, "<leader>env", ":CloakToggle<CR>", { desc = "Toggle environment variables" })
