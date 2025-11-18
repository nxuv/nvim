local borders = require("plugin.config.borders")

return {
    {
        'oredaze/myJABS.nvim', -- fork of a fork of a fork... of a fork
        -- 'matbme/JABS.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            keymap = {
                close = "d",   -- Close buffer. Default D
                jump = "<cr>", -- Jump to buffer. Default <cr>
                h_split = "s", -- Horizontally split buffer. Default s
                v_split = "v", -- Vertically split buffer. Default v
                preview = "p", -- Open buffer preview. Default P
            },

            symbols = {
                current = "C",      -- default 
                split = "S",        -- default 
                alternate = "A",    -- default 
                hidden = "H",       -- default ﬘
                unlisted = "U",     -- default 
                locked = "L",       -- default 
                ro = "R",           -- default 
                edited = "E",       -- default 
                terminal = "T",     -- default 
                default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
            },

            use_devicons = false,

            border = "none",
            relative = "cursor",
            position = { 'right', 'bottom' },

            preview = {
                -- border = 'none'
                border = borders.normal
            }
        },
        event = "VimEnter",
        keys = {
            { "<leader>j", "<cmd>JABSOpen<cr>", mode = "n", noremap = true, silent = true, desc = "[J]abs" },
        }
    }
}
