if vim.g.vim_distro ~= "despair.nvim" then return end

local noremap = require("vim.remap").noremap

-- neovim being beatcsh
-- can't just <esc>xx|dw
-- need to <esc><cr>gv:norm
-- whyyyyyyyyyyyyy
-- :normal f=50i 20|dw
noremap("v", "ga", [[":normal " . input("What to align (motion): ") . "256i <esc><cr>gv:norm" . input("Column to align to: ") . "|dw<cr>"]], { expr=true })

