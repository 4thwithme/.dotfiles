return {
  "wfxr/minimap.vim",
  event = "BufWinEnter",
  lazy = false,
  build = "cargo install --locked code-minimap",
  init = function()
    -- vim.cmd("let g:minimap_width = 15")
    -- vim.cmd("let g:minimap_auto_start = 1")
    -- vim.cmd("let g:minimap_auto_start_win_enter = 1")
    -- vim.cmd("let g:minimap_highlight_search = 1")
    -- vim.cmd("let g:minimap_enable_highlight_colorgroup= 1")
  end,
}
