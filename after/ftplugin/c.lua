vim.cmd([[
    "set omnifunc=ccomplete#Complete
    "so $VIMRUNTIME/autoload/ccomplete.vim
    set complete=.,w,b,u,t
    set omnifunc=syntaxcomplete#Complete

    setlocal path=.,,..,../..,./*,./*/*,../*,~/,~/**,/usr/include/*,**
]])

vim.opt_local.commentstring = "// %s"

if require("modules").can_load("ouroboros") then
    vim.keymap.set("n", "<leader>gh" , "<cmd>Ouroboros<cr>"               , { desc = "[G]o [H]eader", silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gsh", "<cmd>split<cr><cmd>Ouroboros<cr>" , { desc = "[G]o [H]eader", silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gvh", "<cmd>vsplit<cr><cmd>Ouroboros<cr>", { desc = "[G]o [H]eader", silent = true, noremap = true, buffer = true })
else
    vim.keymap.set("n", "<leader>gh",  function() __switch_c_hc("none")   end, { desc = "[G]o [H]eader",          silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gsh", function() __switch_c_hc("split")  end, { desc = "[G]o [S]plit [H]eader",  silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<leader>gvh", function() __switch_c_hc("vsplit") end, { desc = "[G]o [V]split [H]eader", silent = true, noremap = true, buffer = true })
end

