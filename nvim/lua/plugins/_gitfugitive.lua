return {
  'tpope/vim-fugitive',
  lazy = true,
  config = function()
    vim.cmd [[
      nnoremap <leader>gs :Gstatus<CR>
      nnoremap <leader>gd :Gdiff<CR>
      nnoremap <leader>gc :Gcommit<CR>
      nnoremap <leader>gb :Gblame<CR>
      nnoremap <leader>gl :Glog<CR>
      nnoremap <leader>gp :Gpush<CR>
      nnoremap <leader>gP :Gpull<CR>
      nnoremap <leader>gw :Gwrite<CR>
      nnoremap <leader>gW :Gwrite!<CR>
      nnoremap <leader>g2 :diffget //2<CR>
      nnoremap <leader>g3 :diffget //3<CR>
      nnoremap <leader>g2u :diffget //2<CR>:diffupdate<CR>
      nnoremap <leader>g3u :diffget //3<CR>:diffupdate<CR>
      nnoremap <leader>g< :diffget //2<CR>:diffupdate<CR>
      nnoremap <leader>g> :diffget //3<CR>:diffupdate<CR>
      nnoremap <leader>g? :G<CR>
    ]]
  end,
}
