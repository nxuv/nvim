---@diagnostic disable: cast-local-type
-- used for reference
-- https://github.com/ingur/floatty.nvim/tree/main

vim.api.nvim_create_user_command("Float", function(opts)
    local args = opts.fargs

    local width  = math.floor(vim.o.columns * 0.75)
    local height = math.floor(vim.o.lines   * 0.75)

    local col = math.floor((vim.o.columns - width ) / 2)
    local row = math.floor((vim.o.lines   - height) / 2)

    local winopts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "single",
    }

    local win
    local id
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("filetype", "term-docs", { buf = buf })
    vim.api.nvim_create_autocmd({"TermClose"}, {
        buffer = buf,
        callback = function()
            vim.fn.jobstop(id)
        end
    })
    win = vim.api.nvim_open_win(buf, true, winopts)

    local cmd = vim.o.shell
    if #args > 0 then cmd = args end

    id = vim.fn.jobstart(cmd, {
        cwd = vim.fn.getcwd(),
        term = true,
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    })
    if id ==  0 then vim.notify("Invalid arguments") end
    if id == -1 then vim.notify("Command is not executable") end
    vim.cmd.startinsert()
end, { range = false, nargs = "*", bang = false, bar = false, complete = "shellcmd" })
