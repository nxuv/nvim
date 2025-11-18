if vim.g.vim_distro ~= "despair.nvim" then return end

local noremap = require("vim.remap").noremap

-- TODO: make proper resize (using winshift funcs)
noremap("n", "<A-C-h>",     "<C-w><", { desc = "Decrease split width" })
noremap("n", "<A-C-l>",     "<C-w>>", { desc = "Increase split width" })
noremap("n", "<A-C-k>",     "<C-w>-", { desc = "Decrease split height" })
noremap("n", "<A-C-j>",     "<C-w>+", { desc = "Increase split height" })
noremap("n", "<A-C-left>",  "<C-w><", { desc = "Decrease split width" })
noremap("n", "<A-C-right>", "<C-w>>", { desc = "Increase split width" })
noremap("n", "<A-C-up>",    "<C-w>-", { desc = "Decrease split height" })
noremap("n", "<A-C-down>",  "<C-w>+", { desc = "Increase split height" })

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

local function rev_dir(dir)
    if dir == "h" then return "l" end
    if dir == "l" then return "h" end
    if dir == "j" then return "k" end
    if dir == "k" then return "j" end
end

local function dir_func(dir)
    if dir == "h" then return "right" end
    if dir == "l" then return "left" end
    if dir == "j" then return "above" end
    if dir == "k" then return "below" end
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


