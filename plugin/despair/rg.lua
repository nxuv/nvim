if vim.g.vim_distro ~= "despair.nvim" then return end

local noremap = require("vim.remap").noremap
if vim.fn.executable("rg") ~= 1 or vim.g.use_search_find then
    noremap("n", "<leader>ff", [["<cmd>silent sfind! " . input("What")]], { desc = "[F]ind [F]iles" })
    noremap("n", "<leader>fg", [["<cmd>silent lgrep! " . input("What") . " | lopen"]], { desc = "[F]ile [G]rep", expr = true })
    -- noremap("n", "<leader>fr", function() end, { desc = "[F]ind [R]ecent" })
    -- noremap("n", "<leader>rg", function() end, { desc = "[R]ip[G]rep" })
    -- noremap("n", "<leader>ft", function() end, { desc = "[F]ind [T]odo" })
    return
end
local function error(msg) vim.notify(msg, vim.log.levels.error) end

local function fill_qf(lines, title, funcmod)
    vim.cmd("cexpr ['--" .. title .. "--']")
    vim.cmd("copen")
    for _, line in ipairs(lines) do
        if #line ~= 0 then
            if funcmod ~= nil then line = funcmod(line) end
            vim.cmd("caddexpr '" .. line:gsub("'", "''") .. "'")
        end
    end
    vim.fn.feedkeys("j")
end

local function fill_loc(lines, title, funcmod)
    vim.cmd("lexpr ['--" .. title .. "--']")
    vim.cmd("lopen")
    for _, line in ipairs(lines) do
        if #line ~= 0 then
            if funcmod ~= nil then line = funcmod(line) end
            vim.cmd("laddexpr '" .. line:gsub("'", "''") .. "'")
        end
    end
    vim.fn.feedkeys("j")
end

noremap("n", "<leader>ff", function()
    local i = vim.fn.input("File pattern: ")
    if #i == 0 then
        error("Must provide pattern"); return
    end
    local f = vim.system({ "bash", "-c", "rg --files . | rg -i '" .. i .. "'" }, { text = true }):wait()
    if #f.stdout == 0 then
        error("Failed to find " .. i)
    else
        local lines = vim.split(f.stdout, "\n")
        fill_loc(lines, "File Finder", function(l) return "filepath:" .. l end)
    end
    -- vim.print(f)
end, { desc = "[F]ind [F]iles" })

noremap("n", "<leader>fg", function()
    local i = vim.fn.input("Search pattern: ")
    if #i == 0 then
        error("Must provide pattern"); return
    end
    local f = vim.system({ "rg", "-i", "--no-heading", "--line-number", i },
        { text = true }):wait()
    -- vim.print(f)
    if f.code == 0 then
        local lines = vim.split(f.stdout, "\n")
        fill_loc(lines, "File Grep")
    else
        error("Failed to find pattern " .. i)
    end
end, { desc = "[F]ile [G]rep" })

noremap("n", "<leader>fr", function()
    fill_loc(vim.v.oldfiles, "Old Files", function(l) return 'filepath:' .. l end)
end, { desc = "[F]ind [R]ecent" })

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
        error("Failed to find pattern " .. g)
        return
    end
    info(f.stdout)
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

noremap("n", "<leader>ft", function()
    local f = vim.system(
    { "rg", "--no-heading", "--type", "all", "--line-number", ".*(?:TODO|FIXME|TEMP|REFACTOR|REVIEW|HACK|BUG):.*" },
        { text = true }):wait()
    if #f.stdout == 0 then
        error("No todo's found")
    else
        local lines = vim.split(f.stdout, "\n")
        fill_loc(lines, "Todo List")
    end
    -- vim.print(f)
end, { desc = "[F]ind [T]odo" })

