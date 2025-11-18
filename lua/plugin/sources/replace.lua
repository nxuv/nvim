local borders = require("plugin.config.borders")

return {
    {
        "MagicDuck/grug-far.nvim",
        opts = true
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

