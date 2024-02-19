-- cursor
vim.opt.guicursor = "i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150";
vim.opt.cursorline = true

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- tabs & indention
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- appearance
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- line wrapping
vim.opt.wrap = false

--  backspace
vim.opt.backspace = "indent,eol,start"

-- undodir & backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"

-- vim.opt.foldmethod = "indent"
