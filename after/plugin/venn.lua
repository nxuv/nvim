if not require("modules").can_load("cmp") then return end

local noremap = require("remap").noremap

local function get_prev_opts()
    return {
        virtualedit = vim.o.virtualedit,
        keymap = {
            n = {
                H = vim.fn.maparg("H", "n", false, true),
                J = vim.fn.maparg("J", "n", false, true),
                K = vim.fn.maparg("K", "n", false, true),
                L = vim.fn.maparg("L", "n", false, true),
            },
            v = {
                f = vim.fn.maparg("J", "n", false, true),
            }
        }
    }
end

local prev = get_prev_opts()
-- require("venn").set_line({"s","s"," "," "}, '|') -- │
-- require("venn").set_line({"s","s","s"," "}, '+') -- ┤
-- require("venn").set_line({" ","s","s"," "}, '+') -- ┐
-- require("venn").set_line({"s"," "," ","s"}, '+') -- └
-- require("venn").set_line({"s"," ","s","s"}, '+') -- ┴
-- require("venn").set_line({" ","s","s","s"}, '+') -- ┬
-- require("venn").set_line({"s","s"," ","s"}, '+') -- ├
-- require("venn").set_line({" "," ","s","s"}, '-') -- ─
-- require("venn").set_line({"s","s","s","s"}, '+') -- ┼
-- require("venn").set_line({"s"," ","s"," "}, '+') -- ┘
-- require("venn").set_line({" ","s"," ","s"}, '+') -- ┌

local arrow_left  = { "◄", "<", "˂", "←", "⏴", "◀", "⭠", " ", "─" }
local arrow_right = { "►", ">", "˃", "→", "⏵", "▶", "⭢", " ", "─" }
local arrow_up    = { "▲", "^", "˄", "↑", "⏶", "▲", "⭡", " ", "│" }
local arrow_down  = { "▼", "V", "˅", "↓", "⏷", "▼", "⭣", " ", "│" }
local arrow_index = 2
-- 1 - default | ◄ ► ▲ ▼ | lr are thinner and ud are off
-- 2 - ascii   | < > ^ v | ascii obv, possibly replace ^ with A
-- 3 - U+002C_ | ˂ ˃ ˄ ˅ | all are offset
-- 4 - U+0219_ | ← → ↑ ↓ | bad
-- 5 - U+023F_ | ⏴ ⏵ ⏶ ⏷ | ud are disconnected and offset
-- 6 - U+025C_ | ◀ ▶ ▲ ▼ | surprisingly bad
-- 7 - U+02B6_ | ⭠ ⭢ ⭡ ⭣ | udr are disconnected
-- 8 - none    |         | works kinda not good
-- 9 - lines   | ─ ─ │ │ | breaks diagram and inserts T everywhere
require("venn").set_arrow("left" , arrow_left[arrow_index])
require("venn").set_arrow("right", arrow_right[arrow_index])
require("venn").set_arrow("up"   , arrow_up[arrow_index])
require("venn").set_arrow("down" , arrow_down[arrow_index])
-- A note to myself, it seems it needs different arrows
-- to draw anything sanely for some reason

-- venn.nvim: enable or disable keymappings
local function toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        prev = get_prev_opts()
        vim.notify("Venn Enabled", vim.log.levels.INFO)
        vim.b.venn_enabled = true
        vim.o.virtualedit = "all"
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.o.virtualedit = prev.virtualedit
        -- vim.fn.mapset("n", false, prev.keymap.n.H)
        -- vim.fn.mapset("n", false, prev.keymap.n.J)
        -- vim.fn.mapset("n", false, prev.keymap.n.K)
        -- vim.fn.mapset("n", false, prev.keymap.n.L)
        -- vim.fn.mapset("v", false, prev.keymap.v.f)
        vim.notify("Venn Disabled", vim.log.levels.INFO)
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
noremap('n', '<leader>ov', toggle_venn, { desc = "[O]ption [V]enn" })
