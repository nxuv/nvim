if not require("modules").try_setup("nvim-surround", { }) then
    local noremap = require("remap").noremap

    noremap("n", "ys", [["v" . input("Where: ") . "\"sc" . input("Add what: ") . "<c-o>h<c-r>s<esc>"]], { expr=true })
    noremap("n", "cs", [["vi" . input("Change what: ") . "\"sc<c-o>l<c-h><c-h>" . input("To what: ") . "<c-o>h<c-r>s<esc>"]], { expr=true })
end

