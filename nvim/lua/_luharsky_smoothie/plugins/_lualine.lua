return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine with modified theme
    lualine.setup({
     options = { 
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 5000,
          tabline = 5000,
          winbar = 5000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            function()
              local unsaved = 0
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(buf, 'modified') then
                  unsaved = unsaved + 1
                end
              end

              if unsaved == 0 then
                return ''
              else
                return unsaved .. ' UNSAVED'
              end
            end,
          },
        },
        lualine_x = {},
        lualine_y = { 'filename' },
        lualine_z = { 'mode' }
      },
      inactive_sections = {},
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    
    })
  end,
}
