local borders = require("plugin.config.borders")

return {
    -- Colour picker and colour background
    {
        "uga-rosa/ccc.nvim",
        event = { "BufEnter", "BufNew" },
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true
            }
        },
        keys = {
            { "<leader>cp", "<cmd>CccPick<cr>", mode = "n", noremap = true, silent = true, desc = "Opens color picker" },
        },
    },
    {
        'jakemason/ouroboros',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extension_preferences_table = {
                c = { h = 2, hpp = 1 },
                h = { c = 2, cpp = 1 },
                cpp = { hpp = 2, h = 1 },
                hpp = { cpp = 2, c = 1 },
            },
            switch_to_open_pane_if_possible = true,
        },
        cmd = "Ouroboros",
        ft = { "c", "cpp" },
        keys = {
            { "gh", "<cmd>Ouroboros<cr>", mode = "n", noremap = true, silent = true, desc = "Switch to header", ft = { "c", "cpp" } },
        }
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {
            ignore = "^$",
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = true,
            }
        }
    },
    -- Alisgn text [ glip= ]
    {
        'tommcdo/vim-lion',
        config = function()
            vim.g.lion_create_map = 1
            vim.g.lion_squeeze_spaces = 1
        end
    },
    -- cool smart surrounding cs ys ds
    {
        -- 'tpope/vim-surround',
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true
    },

    {
        "nxuv/just.nvim",
        -- dir = "/g/nxuv/just.nvim",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'rcarriga/nvim-notify',
            'j-hui/fidget.nvim',
            "nxuv/jsfunc.nvim",
        },
        event = "VimEnter",
        opts = {
            fidget_message_limit = 32,
            play_sound = true,
            open_qf_on_error = true,
            telescope_borders = {
                prompt = borders.telescope_top,
                results = borders.telescope_bottom,
                preview = borders.telescope
            }
        },
        keys = {
            { "<leader>bd", "<cmd>Just default<cr>", mode = "n", noremap = true, silent = true, desc = "Run default task" },
            { "<leader>bD", "<cmd>Just debug<cr>",   mode = "n", noremap = true, silent = true, desc = "Run debug task" },
            { "<leader>bb", "<cmd>Just build<cr>",   mode = "n", noremap = true, silent = true, desc = "Run build task" },
            { "<leader>br", "<cmd>Just run<cr>",     mode = "n", noremap = true, silent = true, desc = "Run run task" },
            { "<leader>bR", "<cmd>Just release<cr>", mode = "n", noremap = true, silent = true, desc = "Run release task" },
            { "<leader>bf", "<cmd>Just file<cr>",    mode = "n", noremap = true, silent = true, desc = "Run file task" },
            { "<leader>bt", "<cmd>Just tags<cr>",    mode = "n", noremap = true, silent = true, desc = "Run tags task" },
            -- { "<leader>ba", "<cmd>JustSelect<cr>",   mode = "n", noremap = true, silent = true, desc = "Open task selector" },
            { "<leader>bs", "<cmd>JustStop<cr>",     mode = "n", noremap = true, silent = true, desc = "Stop current task" },
        },
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        cmd = "RipSubstitute",
        opts = {
            popupWin = {
                title = "rip-substitute",
                border = borders.normal,
                position = "top",
                matchCountHlGroup = "Keyword",
                noMatchHlGroup = "ErrorMsg",
            },
            keymaps = { -- normal & visual mode, if not stated otherwise
                abort = "q",
                confirm = "<CR>",
                insertModeConfirm = "<C-CR>",
                prevSubstitutionInHistory = "<Up>",
                nextSubstitutionInHistory  = "<Down>",
                toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
                toggleIgnoreCase = "<C-c>",   -- ripgrep's `--ignore-case`
                openAtRegex101 = "R",
            },
            prefill = {
                normal = false
            },
        },
        keys = {
            {
                "<leader>rg",
                function() require("rip-substitute").sub()  end,
                mode = { "n", "x" },
                desc = "[R]ipgrep [S]ubstitute",
            },
        },
    },
}
