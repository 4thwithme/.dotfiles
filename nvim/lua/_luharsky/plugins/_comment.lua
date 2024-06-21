return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      toggler = {
        -- -Line-comment toggle keymap
        line = '?',
      },
      opleader = {
        ---Line-comment keymap
        line = '?',
      },
    })
  end,
  lazy = false,
}
