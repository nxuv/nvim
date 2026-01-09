---@diagnostic disable: cast-local-type
-- used for reference
-- https://github.com/ingur/floatty.nvim/tree/main

vim.api.nvim_create_user_command("Term", function(opts)
    local args = opts.fargs

    local id
    local win = vim.api.nvim_get_current_win()
    local old = vim.api.nvim_win_get_buf(win)
    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_create_autocmd({"TermClose"}, {
        buffer = buf,
        callback = function()
            if vim.api.nvim_buf_is_valid(old) then
                vim.api.nvim_win_set_buf(win, old)
            end
        end
    })

    vim.api.nvim_create_autocmd({"BufEnter"}, {
        buffer = buf,
        callback = function()
            vim.cmd.startinsert()
        end
    })

    vim.keymap.set("t", "<ESC>", [[<c-\><c-n>]], { noremap = true, buffer = buf, silent = true })
    vim.keymap.set("t", "<c-v><c-v>", "<ESC>", { noremap = true, buffer = buf, silent = true })

    vim.api.nvim_win_set_buf(win, buf)

    local cmd = vim.o.shell
    if #args > 0 then cmd = args end

    id = vim.fn.jobstart(cmd, {
        cwd = vim.fn.getcwd(),
        term = true,
        on_exit = function()
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    })

    if id ==  0 then vim.notify("Invalid arguments") end
    if id == -1 then vim.notify("Command is not executable") end

    vim.cmd.startinsert()
end, { range = false, nargs = "*", bang = false, bar = false, complete = "shellcmd" })
