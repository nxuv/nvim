local bufnoremap = require("remap").bufnoremap

bufnoremap("v", "<leader>ta", [[:s/\(|\|\]\|:\|\w\|\s\)\s\{-}\(|\|\[\|:\w\|\s\)/\1\2/g<cr>gv:!column -t -s '|' -o '|'<cr><cmd>nohl<cr>]], { desc = "[T]able [A]lign" })

