local noremap = require("remap").noremap

if vim.fn.executable("just") and not vim.g.use_build_make then
    if require("modules").can_load("just") then
        local just = require("just")
        just.setup({
            fidget_message_limit = 32,
            play_sound = true,
            open_qf_on_error = true,
            autoscroll_qf = false,
        })
        noremap("n", "<leader>bb", "<cmd>Just build<cr>", { desc = "Run build task" })
        noremap("n", "<leader>br", "<cmd>Just run<cr>"  , { desc = "Run run task"   })

        if vim.fn.executable("aplay") ~= 1 then return end
        local async = require("plenary.job")
        local spath = vim.fs.dirname(vim.env.MYVIMRC)
        just.add_callback_on_fail(function()
            async:new( { command = "aplay", args = {string.format("%s/docs/build_error.wav"  , spath), "-q"} }) :start()
        end)
        just.add_callback_on_done(function()
            async:new( { command = "aplay", args = {string.format("%s/docs/build_success.wav", spath), "-q"} }) :start()
        end)
        return
    end

    noremap("n", "<leader>bb", function() vim.cmd("!just build") end)
    noremap("n", "<leader>br", function() vim.cmd("!just run") end)
    return
end

noremap("n", "<leader>bb", function() vim.cmd("make") end)
noremap("n", "<leader>br", function() vim.cmd("make run") end)

