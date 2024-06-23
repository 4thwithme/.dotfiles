return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      attach_to_untracked = true,
      signcolumn = false,
    })
  end,
}
