-- if vim.g.vim_distro ~= "despair.nvim" then return end

local hl = require("vim.highlight").get_highlight
local ti = require("lua.async")

local despair_statusline_reload_interval = nil

local gen_hl_groups = function()
    local colors = {
        replace = hl('Keyword').fg    or "#fe0000",
        insert  = hl('PmenuSbar').bg  or "#fe0000",
        visual  = hl('Number').fg     or "#fe0000",
        command = hl('Identifier').fg or "#fe0000",
        fore    = hl('Normal').fg     or "#fe0000",
        back    = hl('Normal').bg     or "#fe0000"
    }

    local function get_hl_table(fg, bg, opts)
        local r = opts or {}
        if vim.g.is_tty then
            if fg ~= nil then r.ctermfg = tonumber(fg) end
            if bg ~= nil then r.ctermbg = tonumber(bg) end
        else
            if fg ~= nil then r.fg = fg end
            if bg ~= nil then r.bg = bg end
        end
        return r
    end

    vim.api.nvim_set_hl(0, "DesStatusNormal",     get_hl_table(colors.fore, colors.back))
    vim.api.nvim_set_hl(0, "DesStatusNormalBold", get_hl_table(colors.fore, colors.back,   { bold = true } ))
    vim.api.nvim_set_hl(0, "DesStatusInsert",     get_hl_table(colors.fore, colors.insert, { bold = true } ))
    vim.api.nvim_set_hl(0, "DesStatusReplace",    get_hl_table(colors.replace, nil, { bold = true, reverse = true } ))
    vim.api.nvim_set_hl(0, "DesStatusVisual",     get_hl_table(colors.visual , nil, { bold = true, reverse = true } ))
    vim.api.nvim_set_hl(0, "DesStatusCommand",    get_hl_table(colors.command, nil, { bold = true, reverse = true } ))
    vim.api.nvim_set_hl(0, "DesStatusRedFg",      get_hl_table(colors.replace, nil))

end

local reset_stline = function()
    if despair_statusline_reload_interval ~= nil then
        ti.clear_interval(despair_statusline_reload_interval)
        despair_statusline_reload_interval = nil
        vim.notify("Cleared statusline reload interval")
    end
end

local start_stline = function()
    reset_stline()

    local interval_time = math.floor(250)

    local draw_func = function()
        -- if vim.v.errmsg ~= "" then
        --     reset_stline()
        --     vim.v.errmsg = ""
        --     return
        -- end

        local function stline_get_mode()
            local m = vim.fn.mode()
            if m == "n"  then return " NOR " end
            if m == "R"  then return " REP " end
            if m == "v"  then return " VIS " end
            if m == "V"  then return " V-L " end
            if m == "" then return " V-B " end
            if m == "t"  then return " TER " end
            if m == "o"  then return " OPT " end
            if m == "c"  then return " COM " end
            if m == "i"  then return " INS " end
            return " [" .. m .. "]"
        end

        local function get_mode_hl()
            local m = vim.fn.mode()
            if m == "n"  then return "%#DesStatusNormalBold#" end
            if m == "R"  then return "%#DesStatusReplace#" end
            if m == "v"  then return "%#DesStatusVisual#" end
            if m == "V"  then return "%#DesStatusVisual#" end
            if m == "" then return "%#DesStatusVisual#" end
            if m == "t"  then return "%#DesStatusInsert#" end
            if m == "o"  then return "%#DesStatusInsert#" end
            if m == "c"  then return "%#DesStatusInsert#" end
            if m == "i"  then return "%#DesStatusInsert#" end
            return "%#DesStatusNormalBold#"
        end

        local function get_tape()
            local reg_cur = vim.fn.toupper(vim.fn.reg_recorded())
            local reg_rec = vim.fn.toupper(vim.fn.reg_recording())
            if reg_rec ~= "" then
                local stage = math.floor((vim.loop.now() / 250) % 4)
                if stage == 0     then return "%#DesStatusRedFg# [o o] Recording " .. reg_rec .. "...%#Normal#" end
                if stage % 4 == 1 then return "%#DesStatusRedFg# [o⠠o] Recording " .. reg_rec .. "...%#Normal#" end
                if stage % 4 == 2 then return "%#DesStatusRedFg# [o⠤o] Recording " .. reg_rec .. "...%#Normal#" end
                if stage % 4 == 3 then return "%#DesStatusRedFg# [o⠄o] Recording " .. reg_rec .. "...%#Normal#" end
            end
            if reg_cur ~= "" then
                return " [o o] Side " .. reg_cur
            end
            return " [o o] Side ?"
        end

        vim.opt.statusline = get_mode_hl() .. stline_get_mode() .. "%#DesStatusNormal# %f%m%h%r %=%v %{substitute(getcwd(),$HOME,'~','')} %{&ft}" .. get_tape() .. " " .. get_mode_hl() .. " %P %#Normal#"

    end


    gen_hl_groups()
    draw_func()
    despair_statusline_reload_interval = ti.set_interval(interval_time, draw_func)
end

if despair_statusline_reload_interval == nil then
    local cs = require("sys.config")
    cs.theme.on_reload(gen_hl_groups)
    start_stline()

    vim.api.nvim_create_user_command("StatuslineReset", reset_stline, {})
end

