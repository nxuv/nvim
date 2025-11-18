return {
    -- lsp progressbar
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = {
                    winblend = 0
                },
            }
        }
    },
    -- notification engine
    {
        'rcarriga/nvim-notify',
        opts = {
            background_color = 'Normal',
            stages = 'slide',

            on_open = function(win)
                vim.api.nvim_win_set_config(win, { border = "single" })
            end,
            render = "wrapped-compact",
            minimum_width = 0,
            level = 2,
        }
    },
    -- override input handling (makes input pop up sometimes...)
    {
        'stevearc/dressing.nvim',
        opts = {
            input = {
                enabled = true,
            },
            select = {
                enabled = true,
                backend = { "nui", "fzf_lua", "telescope", "builtin" }
            },
        }
    },
    {
        "luukvbaal/nnn.nvim",
        opts = {
            picker = {
                -- cmd = "tmux new-session nnn -Pp",
                -- session = "shared",
                fullscreen = true,
            },
            auto_open = {
                setup = nil,
                tabpage = nil,
                empty = false,
            },
            auto_close = true,
            replace_netrw = "picker",
        },
        event = "VimEnter",
        keys = {
            { "-", "<cmd>NnnPicker %:p<cr>", mode = "n", noremap = true, silent = true, desc = "[F]ile [J]ump" },
            -- { "-", "<cmd>NnnPicker %:p<cr>", mode = "t", noremap = true, silent = true, desc = "[F]ile [J]ump" },
        }
    }
}
