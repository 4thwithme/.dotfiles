return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "4thwithme/black.nvim",
    lazy = false,
    priority = 1000,

  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha"
      })
    end
  }
}
