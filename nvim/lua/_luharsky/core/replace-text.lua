local M = {}

-- Visual find and replace function
function M.visual_find_replace()
    -- Save the current visual selection to register z
    vim.cmd([[normal! gv"zy]])

    -- Get the selected text from register z
    local selected_text = vim.fn.getreg("z")

    -- Handle empty selection
    if selected_text == "" then
        return
    end

    -- Escape special characters for search pattern
    local escaped_text = vim.fn.escape(selected_text, [[/\.*$^~[]])

    -- Open input prompt with the selected text pre-filled
    vim.ui.input({ prompt = "Replace with: ", default = selected_text }, function(input)
        if input and input ~= nil then
            -- Perform global search and replace
            local cmd = string.format("%%s/%s/%s/g", escaped_text, vim.fn.escape(input, [[/&\]]))
            pcall(function() vim.cmd(cmd) end)
            vim.cmd("nohl") -- Clear search highlighting
        end
    end)
end

-- Make the function globally accessible
_G.visual_find_replace = M.visual_find_replace

return M

