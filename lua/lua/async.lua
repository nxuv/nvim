-- Async
local M = {}

-- Creating a simple setTimeout wrapper
M.set_timeout = function(timeout, callback)
    local timer = vim.uv.new_timer()
    timer:start(timeout, 0, function()
        timer:stop()
        timer:close()
        vim.schedule(callback)
    end)
    return timer
end

-- Creating a simple setInterval wrapper
M.set_interval = function(interval, callback)
    local timer = vim.uv.new_timer()
    timer:start(interval, interval, function()
        vim.schedule(callback)
    end)
    return timer
end

-- And clearInterval
M.clear_interval = function(timer)
    timer:stop()
    timer:close()
end

return M
