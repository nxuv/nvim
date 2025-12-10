local noremap = require("remap").noremap

if require("modules").try_setup("smart-splits", { }) then
    noremap("n", "<A-C-left>" , function() require('smart-splits').resize_left(2) end , { desc = "Resizes window to left" } )
    noremap("n", "<A-C-right>", function() require('smart-splits').resize_right(2) end, { desc = "Resizes window to right" })
    noremap("n", "<A-C-up>"   , function() require('smart-splits').resize_up(2) end   , { desc = "Resizes window up" } )
    noremap("n", "<A-C-down>" , function() require('smart-splits').resize_down(2) end , { desc = "Resizes window down" } )
    noremap("n", "<A-C-h>"    , function() require('smart-splits').resize_left(2) end , { desc = "Resizes window to left" } )
    noremap("n", "<A-C-l>"    , function() require('smart-splits').resize_right(2) end, { desc = "Resizes window to right" })
    noremap("n", "<A-C-k>"    , function() require('smart-splits').resize_up(2) end   , { desc = "Resizes window up" } )
    noremap("n", "<A-C-j>"    , function() require('smart-splits').resize_down(2) end , { desc = "Resizes window down" } )
else
    -- TODO: make proper resize (using winshift funcs)
    noremap("n", "<A-C-left>",  "<C-w><", { desc = "Decrease split width" })
    noremap("n", "<A-C-right>", "<C-w>>", { desc = "Increase split width" })
    noremap("n", "<A-C-up>",    "<C-w>-", { desc = "Decrease split height" })
    noremap("n", "<A-C-down>",  "<C-w>+", { desc = "Increase split height" })
    noremap("n", "<A-C-h>",     "<C-w><", { desc = "Decrease split width" })
    noremap("n", "<A-C-l>",     "<C-w>>", { desc = "Increase split width" })
    noremap("n", "<A-C-k>",     "<C-w>-", { desc = "Decrease split height" })
    noremap("n", "<A-C-j>",     "<C-w>+", { desc = "Increase split height" })
end

