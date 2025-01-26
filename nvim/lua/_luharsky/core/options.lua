vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- cursor
vim.opt.guicursor = "i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150"
vim.opt.cursorline = true

-- no cmdline
opt.showcmd = false

-- line numbers
opt.nu = true
opt.relativenumber = true

-- tabs & indention
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- apperence
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--  backspace
opt.backspace = "indent,eol,start"

-- undodir & backup
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.scrolloff = 10
opt.isfname:append("@-@")
opt.updatetime = 50
opt.colorcolumn = "0"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 0
vim.opt.foldenable = false

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("LualineBuffersDelete", function(args)
	local buffers = require("lualine.components.buffers")
	local buf_pos = args.fargs[1] == "$" and #buffers.bufpos2nr or tonumber(args.fargs[1])
	print("buf_pos", buf_pos)
	if buf_pos >= 0 and buf_pos <= #buffers.bufpos2nr then
		vim.api.nvim_buf_delete(buffers.bufpos2nr[buf_pos], { force = true })
	elseif not args.bang then
		error("Error: Unable to delete buffer position out of range")
	end
end, { desc = "Delete buffer based on lualine-buffers index", force = true, nargs = 1, bang = true })

vim.opt.laststatus = 0
