local noremap = require("remap").noremap

if require("modules").try_setup("winshift", {
    keymaps = { disable_defaults = false, }
}) then
    noremap("n", "<A-S-left>" , "<cmd>WinShift left<cr>" , { desc = "Moves window left" } )
    noremap("n", "<A-S-right>", "<cmd>WinShift right<cr>", { desc = "Moves window right" })
    noremap("n", "<A-S-up>"   , "<cmd>WinShift up<cr>"   , { desc = "Moves window up" } )
    noremap("n", "<A-S-down>" , "<cmd>WinShift down<cr>" , { desc = "Moves window down" } )
    noremap("n", "<A-S-h>"    , "<cmd>WinShift left<cr>" , { desc = "Moves window left" } )
    noremap("n", "<A-S-l>"    , "<cmd>WinShift right<cr>", { desc = "Moves window right" })
    noremap("n", "<A-S-k>"    , "<cmd>WinShift up<cr>"   , { desc = "Moves window up" } )
    noremap("n", "<A-S-j>"    , "<cmd>WinShift down<cr>" , { desc = "Moves window down" } )
else
    local function win_edge(dir)
        local cw = vim.api.nvim_get_current_win()
        vim.cmd("wincmd " .. dir)
        local nw = vim.api.nvim_get_current_win()
        if cw == nw then
            return true
        else
            vim.cmd("wincmd p")
            return false
        end
    end

    local function win_edge_full(dir)
        if dir ~= "h" then if not win_edge("h") then return false end end
        if dir ~= "j" then if not win_edge("j") then return false end end
        if dir ~= "k" then if not win_edge("k") then return false end end
        if dir ~= "l" then if not win_edge("l") then return false end end
        return true
    end

    local function move_win(dir)
        if win_edge(dir) then
            vim.cmd("wincmd " .. vim.fn.toupper(dir))
        else
            local edge = win_edge_full(dir)
            local bufnr = vim.api.nvim_get_current_buf()
            vim.cmd("hide")
            if not edge then vim.cmd("wincmd " .. dir) end

            -- TODO: get proper splits...
            if dir == "h" or dir == "l" then
                vim.cmd("split")
            else
                -- vim.cmd(dir_func(rev_dir(dir)) .. " split")
                vim.cmd("vsplit")
            end
            vim.api.nvim_set_current_buf(bufnr)
        end
    end

    local function wm_h() move_win("h") end
    local function wm_l() move_win("l") end
    local function wm_j() move_win("j") end
    local function wm_k() move_win("k") end

    noremap("n", "<A-S-h>",     wm_h, { desc = "Move split left" })
    noremap("n", "<A-S-l>",     wm_l, { desc = "Move split right" })
    noremap("n", "<A-S-left>",  wm_h, { desc = "Move split left" })
    noremap("n", "<A-S-right>", wm_l, { desc = "Move split right" })
    noremap("n", "<A-S-k>",     wm_k, { desc = "Move split up" })
    noremap("n", "<A-S-j>",     wm_j, { desc = "Move split down" })
    noremap("n", "<A-S-up>",    wm_k, { desc = "Move split up" })
    noremap("n", "<A-S-down>",  wm_j, { desc = "Move split down" })
end
