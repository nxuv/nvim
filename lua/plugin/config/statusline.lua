-- Statusline
local hl = require("vim.highlight").get_highlight

-- Basic theme definition
local M = {}

M.get_colors = function()
    -- return {
    --     normal  = hl('PmenuSel').bg or "#000000",
    --     replace = hl('Keyword').fg or "#000000",
    --     insert  = hl('VertSplit').fg or "#000000",
    --     visual  = hl('Number').fg or "#000000",
    --     -- insert  = hl('Number').fg or "#000000",
    --     -- visual  = hl('String').fg or "#000000",
    --     command = hl('Identifier').fg or "#000000",
    --     back1   = hl('Normal').bg or "#000000",
    --     fore    = hl('Normal').fg or "#000000",
    --     normal   = hl('StatusLine').bg or "#000000",
    -- }
    return {
        -- insert  = hl('Number').fg or "#000000",
        -- visual  = hl('String').fg or "#000000",
        replace = hl('Keyword').fg    or "#fe0000",
        insert  = hl('PmenuSbar').bg  or "#fe0000",
        visual  = hl('Number').fg     or "#fe0000",
        command = hl('Identifier').fg or "#fe0000",
        fore    = hl('Normal').fg     or "#fe0000",
        back    = hl('Normal').bg     or "#fe0000"
    }
end

M.get_theme = function()
    local S = {}
    local colors = M.get_colors()

    S = {
        normal = {
            a = { bg = colors.back, fg = colors.fore, gui = 'bold' },
            b = { bg = colors.back, fg = colors.fore },
            c = { bg = colors.back, fg = colors.fore },
        },
        insert = {
            a = { bg = colors.insert, fg = colors.fore, gui = 'bold' },
            b = { bg = colors.back, fg = colors.insert },
            c = { bg = colors.back, fg = colors.fore },
        },
        replace = {
            a = { fg = colors.replace, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.replace },
            c = { bg = colors.back, fg = colors.fore },
        },
        visual = {
            a = { fg = colors.visual, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.visual },
            c = { bg = colors.back, fg = colors.fore },
        },
        command = {
            a = { fg = colors.command, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.command },
            c = { bg = colors.back, fg = colors.fore },
        },
    }

    S.terminal = S.command
    S.inactive = S.normal

    return S
end

return M
