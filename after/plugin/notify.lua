---@diagnostic disable: duplicate-set-field
if not require("modules").can_load("notify") then return end

local notify = require("notify")

notify.setup({
    background_color = 'Normal',
    stages = 'slide',

    on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = "single" })
    end,
    render = "wrapped-compact",
    minimum_width = 0,
    level = 2,
})

local M = {}
M.vim_notify       = vim.notify
M.nvim_err_write   = vim.api.nvim_err_write
M.nvim_err_writeln = vim.api.nvim_err_writeln
M.nvim_echo        = vim.api.nvim_echo

vim.notify = vim.schedule_wrap(notify)

vim.api.nvim_err_write = function(message)
    notify(message, vim.log.levels.ERROR)
end

vim.api.nvim_err_writeln = function(message)
    notify(message, vim.log.levels.ERROR)
end

-- vim.api.nvim_echo = function(chunks, _, _)
--     if chunks == nil then return end
--     local message = ""
--     for _, v in ipairs(chunks) do
--         if v ~= nil and v[1] ~= nil and v[1] ~= "" and v[1] ~= "\n" then
--             message = message .. "\n" .. v[1]
--         end
--     end
--     if message == "" then return end
--     -- print(vim.inspect(message))
--     notify(message, vim.log.levels.INFO)
-- end

vim.api.nvim_create_user_command("UnregisterNotify", function()
    vim.notify               = M.vim_notify
    vim.api.nvim_err_write   = M.nvim_err_write
    vim.api.nvim_err_writeln = M.nvim_err_writeln
    vim.echo                 = M.nvim_echo
end, {})

