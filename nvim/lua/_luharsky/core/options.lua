vim.cmd("let g:netrw_liststyle = 3");

local opt = vim.opt;

-- cursor
vim.opt.guicursor = "i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150";
vim.opt.cursorline = true

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

-- vim.opt.foldmethod = "indent"

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- split
opt.splitright = true
opt.splitbelow = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
