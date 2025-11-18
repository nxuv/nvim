-- Key functions
local M = {}

local function utf8len(s)
    return select(2, s:gsub('[^\128-\193]', ''))
end

M.line_len = function(c_row)
    return utf8len(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)[1])
end

M.delete_char = function(is_backspace)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local c_row = cursor_pos[1] - 1
    local c_col = cursor_pos[2]
    local row_count = vim.api.nvim_buf_line_count(0)
    local col_count = M.line_len(c_row)
    -- vim.notify(vim.inspect(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)))

    if is_backspace == 1 then
        if c_row == 0 and c_col == 0 then return end
        if c_col == 0 then
            vim.api.nvim_buf_set_text(0, c_row - 1, M.line_len(c_row - 1), c_row, c_col, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col - 1, c_row, c_col, {})
        end
    else
        if c_row == row_count - 1 and c_col == col_count then return end
        if c_col == col_count then
            vim.api.nvim_buf_set_text(0, c_row, col_count, c_row + 1, 0, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col, c_row, c_col + 1, {})
        end
    end
    -- bs - start higher then end
    -- dle - invalid end_col: out of range
end

M.lineHome = function()
    local x = vim.fn.col('.')
    vim.fn.execute('normal ^')
    if x == vim.fn.col('.') then
        vim.fn.execute('normal 0')
    end
end

M.lineEnd = function()
    local x = vim.fn.col('.')
    vim.fn.execute('normal g_')
    vim.fn.execute("normal l")
    if x == vim.fn.col('.') then
        vim.fn.execute('normal g$')
    end
end

M.cd_filedir = function()
    local cdir = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cdir)
    vim.notify(vim.fn.getcwd())
end

M.open_link_vis = function()
    vim.fn.feedkeys('"vy', "x")
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
    local s = vim.fn.getreg("v")
    vim.ui.open(vim.fn.expand(s))
    vim.notify(s)
end

M.open_link_norm = function()
    -- "x" makes it fast
    vim.fn.feedkeys("viW", "x")
    M.open_link_vis()
end

local function pad_string_vis(s)
    local o = s:match("^%s*(.*)"):match("(.-)%s*$")
    local ll = 76
    local lp = math.floor((ll - utf8len(o)) / 2)
    local rp = lp
    if (lp + rp + utf8len(o)) ~= ll then rp = rp + 1 end
    o = string.format("- %" .. tostring(lp) .. "s%s%" .. tostring(rp) .. "s -", " ", o, " ")
    return o
end

local function pad_string_nor(s)
    local o = s:match("^%s*(.*)"):match("(.-)%s*$")
    local ll = 74
    local lp = math.floor((ll - utf8len(o)) / 2)
    local rp = lp
    if (lp + rp + utf8len(o)) ~= ll then rp = rp + 1 end
    o = "- " .. string.rep("-", lp) .. " " .. o .. " " .. string.rep("-", rp) .. " -"
    return o
end

M.uncomment_line = function()
    vim.fn.feedkeys("gccV", "x")
    pcall(vim.cmd, "s/- -\\+ \\(.*\\) -\\+ -$/\\1/")
    vim.cmd("nohl")
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
end

M.uncomment_box = function()
    vim.fn.feedkeys("gccgv", "x")
    pcall(vim.cmd, "'<,'>s/- -\\+ -\\n//")
    vim.fn.feedkeys("gvk", "x")
    pcall(vim.cmd, "'<,'>s/-\\s\\+\\(.\\{-}\\)\\s\\+-$/\\1/")
    vim.cmd("nohl")
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
end

M.comment_sep = function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local c_row = cursor_pos[1]
    vim.api.nvim_buf_set_lines( 0, c_row - 1, c_row - 1, false, { "- " .. string.rep("-", 76) .. " -" })
    vim.fn.feedkeys("kgcc", "x")
    cursor_pos[1] = cursor_pos[1] + 1
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end

M.comment_line = function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local c_row = cursor_pos[1]
    local lines = vim.api.nvim_buf_get_lines(0, c_row - 1, c_row, false)
    vim.api.nvim_buf_set_lines( 0, c_row - 1, c_row, false, { pad_string_nor(lines[1]) })
    vim.fn.feedkeys("gcc", "x")
end

M.comment_box = function()
    local vis_st = vim.fn.getpos("v")[2]
    local vis_en = vim.fn.getpos(".")[2]
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
    if vis_st > vis_en then
        vis_en = vis_en + vis_st -- 2  + 14 = 16
        vis_st = vis_en - vis_st -- 16 - 14 = 2
        vis_en = vis_en - vis_st -- 16 - 2  = 14
    end
    -- nvim_buf_get_lines({buffer}, {start}, {end}, {strict_indexing})
    local lines = vim.api.nvim_buf_get_lines(0, vis_st - 1, vis_en, false)
    for i, l in ipairs(lines) do
        lines[i] = pad_string_vis(l)
    end
    table.insert(lines, 1, "- ---------------------------------------------------------------------------- -")
    table.insert(lines,    "- ---------------------------------------------------------------------------- -")

    -- nvim_buf_set_lines({buffer}, {start}, {end}, {strict_indexing}, {replacement})
    vim.api.nvim_buf_set_lines( 0, vis_st - 1, vis_en, false, {})
    vim.api.nvim_buf_set_lines( 0, vis_st - 1, vis_st - 1, false, lines)
    vim.fn.feedkeys(tostring(vis_st) .. "ggV" .. tostring(vis_en + 2) .. "gggc", "x")
    vim.fn.setpos(".", {0, vis_st, 1, 0})
end

M.quit_term = function ()
    if vim.fn.confirm("Do you want to delete terminal buffer?", "&Yes\n&No", 1) == 1 then
        vim.cmd("bd!")
    else
        vim.cmd("x")
    end
end

return M

