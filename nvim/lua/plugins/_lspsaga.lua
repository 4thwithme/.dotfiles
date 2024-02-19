return {
  'nvimdev/lspsaga.nvim',
  event = 'BufRead',
  lazy = true,
  config = function()
    require('lspsaga').setup({})
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
  }
}
