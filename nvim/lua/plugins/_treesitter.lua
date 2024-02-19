return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "prisma", "astro", "json", "markdown", "markdown_inline" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    });
  end,
}
