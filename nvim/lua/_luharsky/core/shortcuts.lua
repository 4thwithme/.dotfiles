vim.keymap.set(
	"i",
	"clg",
	"// eslint-disable-next-line no-console\nconsole.log()<Left>",
	{ expr = false, silent = true }
)
vim.keymap.set(
	"i",
	"clr",
	"// eslint-disable-next-line no-console\nconsole.error()<Left>",
	{ expr = false, silent = true }
)
