---@diagnostic disable: missing-return-value

return { {
    'nanozuki/tabby.nvim',
    event = { 'VimEnter' },
    config = function()
        vim.o.showtabline = 2
        local tabby = require("tabby.tabline")
        local lualine_theme = require("plugin.config.statusline")
        local get_colors = lualine_theme.get_colors

        local function get_theme()
            local line_colors = get_colors()
            if line_colors.back == "" then line_colors.back = nil  end
            local theme = {
                fill        = { fg = line_colors.insert, bg = line_colors.back   } ,
                head        = { fg = line_colors.fore  , bg = line_colors.back } ,
                current_tab = { fg = line_colors.fore  , bg = line_colors.back } ,
                tab         = { fg = line_colors.insert, bg = line_colors.back   } ,
                win         = { fg = line_colors.fore  , bg = line_colors.back } ,
                tail        = { fg = line_colors.fore  , bg = line_colors.back } ,
            }
            return theme
        end

        local function source_func()
            -- vim.print(vim.inspect(theme))
            tabby.set(
                function(line)
                    local theme = get_theme()
                    return {
                        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                            ---@diagnostic disable-next-line: redefined-local
                            local theme = get_theme()
                            local hl = win.is_current() and theme.current_tab or theme.tab
                            return {
                                line.sep('', theme.win, theme.win),
                                win.buf_name(),
                                line.sep('', theme.win, theme.win),
                                hl = hl,
                                margin = ' ',
                            }
                        end),
                        line.spacer(),
                        line.tabs().foreach(function(tab)
                            local hl = tab.is_current() and theme.current_tab or theme.tab
                            return {
                                line.sep('', hl, hl),
                                (tab.is_current() and '[' or ' ') .. tab.number() .. (tab.is_current() and ']' or ' '),
                                line.sep('', hl, hl),
                                hl = hl,
                                margin = ' ',
                            }
                        end),
                        hl = theme.fill,
                    }
                end, {}
            )
        end

        source_func()

        -- require("lib.col").on_reload(source_func)
    end
},
}
