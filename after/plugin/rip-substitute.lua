local noremap = require("remap").noremap

if require("modules").try_setup("rip-substitute", {
    popupWin = {
        title = "rip-substitute",
        border = require("theme").border_normal,
        position = "top",
        matchCountHlGroup = "Keyword",
        noMatchHlGroup = "ErrorMsg",
    },
    keymaps = { -- normal & visual mode, if not stated otherwise
        abort = "q",
        confirm = "<CR>",
        insertModeConfirm = "<C-CR>",
        prevSubstitutionInHistory = "<Up>",
        nextSubstitutionInHistory  = "<Down>",
        toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
        toggleIgnoreCase = "<C-c>",   -- ripgrep's `--ignore-case`
        openAtRegex101 = "R",
    },
    prefill = { normal = false },
}) then
    noremap("n", "<leader>rg", function() require("rip-substitute").sub() end, { desc = "[R]ipgrep [S]ubstitute" })
else
    noremap("n", "<leader>rg", function()
        local g = vim.fn.input("Grep pattern: ")
        if #g == 0 then
            error("No pattern supplied, aborting")
            return
        end
        local r = vim.fn.input("Replace pattern: ")
        local c = vim.fn.expand("%:p")
        local f = vim.system({ "rg", g, "--no-heading", "--line-number", "-r", r, c }, { text = true }):wait()
        -- info(vim.inspect(f))
        -- rg -F "from-pattern" -r "to-pattern" filename
        if f.code == 1 then
            vim.notify("Failed to find pattern " .. g, vim.log.levels.ERROR)
            return
        end
        vim.notify(f.stdout, vim.log.levels.INFO)
        local yn = vim.fn.confirm("Do you want to apply changes?", "&Yes\n&No")
        if yn ~= 1 then return end
        local lines = vim.split(f.stdout, "\n")
        for _, line in ipairs(lines) do
            if #line ~= 0 then
                local _, e = line:find("%d+:")
                local l = line:sub(e + 1)
                local n = tonumber(line:sub(1, e - 1)) - 1
                -- vim.print(tostring(n) .. "--" .. l)
                vim.api.nvim_buf_set_lines(0, n, n + 1, false, { l })
                -- TODO: add visual replacement
            end
        end
    end, { desc = "[R]ip[G]rep" })
end
