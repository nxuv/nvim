return {
    -- Move splits [ A-S-Right ... ]
    {
        'sindrets/winshift.nvim',
        event = "VimEnter",
        opts = {
            keymaps = {
                disable_defaults = false,
            }
        },
        keys = {
            { "<A-S-left>",  "<cmd>WinShift left<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window left" },
            { "<A-S-right>", "<cmd>WinShift right<cr>", mode = "n", noremap = true, silent = true, desc = "Moves window right" },
            { "<A-S-up>",    "<cmd>WinShift up<cr>",    mode = "n", noremap = true, silent = true, desc = "Moves window up" },
            { "<A-S-down>",  "<cmd>WinShift down<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window down" },
            { "<A-S-h>",     "<cmd>WinShift left<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window left" },
            { "<A-S-l>",     "<cmd>WinShift right<cr>", mode = "n", noremap = true, silent = true, desc = "Moves window right" },
            { "<A-S-k>",     "<cmd>WinShift up<cr>",    mode = "n", noremap = true, silent = true, desc = "Moves window up" },
            { "<A-S-j>",     "<cmd>WinShift down<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window down" },
        }
    },
    -- Resize splits [ A-C-Right ... ]
    {
        'mrjones2014/smart-splits.nvim',
        config = true,
        event = "VimEnter",
        keys = {
            { "<A-C-left>" , function() require('smart-splits').resize_left(2) end , mode = "n", noremap = true, silent = true, desc = "Resizes window to left" } ,
            { "<A-C-right>", function() require('smart-splits').resize_right(2) end, mode = "n", noremap = true, silent = true, desc = "Resizes window to right" },
            { "<A-C-up>"   , function() require('smart-splits').resize_up(2) end   , mode = "n", noremap = true, silent = true, desc = "Resizes window up" }      ,
            { "<A-C-down>" , function() require('smart-splits').resize_down(2) end , mode = "n", noremap = true, silent = true, desc = "Resizes window down" }    ,
            { "<A-C-h>"    , function() require('smart-splits').resize_left(2) end , mode = "n", noremap = true, silent = true, desc = "Resizes window to left" } ,
            { "<A-C-l>"    , function() require('smart-splits').resize_right(2) end, mode = "n", noremap = true, silent = true, desc = "Resizes window to right" },
            { "<A-C-k>"    , function() require('smart-splits').resize_up(2) end   , mode = "n", noremap = true, silent = true, desc = "Resizes window up" }      ,
            { "<A-C-j>"    , function() require('smart-splits').resize_down(2) end , mode = "n", noremap = true, silent = true, desc = "Resizes window down" }    ,
        }
    },

}
