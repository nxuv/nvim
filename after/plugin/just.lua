local noremap = require("remap").noremap

if vim.fn.executable("just") and not vim.g.use_build_make then
    if require("modules").try_setup("just", {
        fidget_message_limit = 32,
        play_sound = true,
        open_qf_on_error = true,
    }) then
        noremap("n", "<leader>bb", "<cmd>Just build<cr>", { desc = "Run build task" })
        noremap("n", "<leader>br", "<cmd>Just run<cr>"  , { desc = "Run run task"   })
        return
    end

    noremap("n", "<leader>bb", function() vim.cmd("!just build") end)
    noremap("n", "<leader>br", function() vim.cmd("!just run") end)
    return
end

noremap("n", "<leader>bb", function() vim.cmd("make") end)
noremap("n", "<leader>br", function() vim.cmd("make run") end)


