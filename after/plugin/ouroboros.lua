---@diagnostic disable: lowercase-global, param-type-mismatch
if not require("modules").try_setup("ouroboros", {
    extension_preferences_table = {
        c = { h = 2, hpp = 1 },
        h = { c = 2, cpp = 1 },
        cpp = { hpp = 2, h = 1 },
        hpp = { cpp = 2, c = 1 },
    },
    switch_to_open_pane_if_possible = true,
}) then
    __switch_c_hc = function(split_type)
        local flipname
        if vim.fn.match(vim.fn.expand("%"), "\\.c") > 0 then
            flipname = vim.fn.substitute(vim.fn.expand("%:t"), "\\.c\\(.*\\)", ".h\\1", "")
        elseif vim.fn.match(vim.fn.expand("%"), "\\.h") > 0 then
            flipname = vim.fn.substitute(vim.fn.expand("%:t"), "\\.h\\(.*\\)", ".c\\1", "")
        else return end
        local ok, _ = pcall(vim.cmd, "find " .. flipname)
        if not ok then
            vim.notify("Failed to find '" .. flipname .. "' in path.", vim.log.levels.ERROR)
        end
        if split_type ~= "none" then vim.cmd(split_type .. " | wincmd p | edit # | wincmd p") end
    end
end
