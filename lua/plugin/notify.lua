---@diagnostic disable: duplicate-set-field
local can_load = require("vim.modules").can_load

local hl_group = {
    OFF = "Comment",
    INFO = "Normal",
    WARN = "Warning",
    DEBUG = "Debug",
    ERROR = "Error",
    TRACE = "Trace"
}

if can_load("notify") then
    local notify = require("notify")

    local vim_notify = vim.notify
    local nvim_err_write = vim.api.nvim_err_write
    local nvim_err_writeln = vim.api.nvim_err_writeln
    local nvim_echo = vim.api.nvim_echo

    ---@diagnostic disable-next-line: param-type-mismatch
    vim.notify = vim.schedule_wrap(notify)

    vim.api.nvim_err_write = function(message)
        notify(message, vim.log.levels.ERROR)
    end

    vim.api.nvim_err_writeln = function(message)
        notify(message, vim.log.levels.ERROR)
    end

    vim.api.nvim_echo = function(chunks, history, opts)
        if chunks == nil then return end
        local message = ""
        for i, v in ipairs(chunks) do
            if v[1] ~= nil then
                message = message .. "\n" .. v[1]
            end
        end
        if message == nil then return end
        notify(message, vim.log.levels.INFO)
    end

    vim.api.nvim_create_user_command(
        'Messages',
        function()
            local hist = {}

            for _, v in pairs(notify.history()) do
                for _, m in pairs(v.message) do
                    if m == "" then goto continue end
                    table.insert(hist, { m .. '\n', hl_group[v.level] })
                    ::continue::
                end
            end

            nvim_echo({ { "--- Neovim Messages: ---\n", "Comment" } }, false, {})
            vim.cmd("messages")
            nvim_echo({ { "\n--- Notify Messages: ---\n", "Comment" } }, false, {})
            nvim_echo(hist, false, {})
        end,
        {})
end
