local noremap = require("remap").noremap

if require("modules").try_setup("nnn", {
    picker = {
        -- cmd = "tmux new-session nnn -Pp",
        -- session = "shared",
        fullscreen = true,
    },
    auto_open = {
        setup = nil,
        tabpage = nil,
        empty = false,
    },
    auto_close = true,
    replace_netrw = "picker",
}) then
    noremap("n", "-", "<cmd>NnnPicker %:p<cr>")
else
    noremap("n", "-", ':Ex <bar> :sil! /<C-R>=expand("%:t")<CR><CR>')
end

