if require("modules").can_load("fzf-lua") then
    local noremap = require("remap").noremap

    local fzf = require("fzf-lua")

    -- List of what I usually wouldn't need to see in fzf
    local file_ignores = {
        -- images
        "png", "jpg", "jpeg", "gif", "bmp", "ico", "webp",
        "gpl", "kra", "tiff", "psd", "pdf", "dwg", "svg",
        -- fonts
        "ttf", "woff", "otf",
        -- audio
        "ogg", "mp3", "wav", "aiff", "flac", "oga", "mogg", "raw", "wma",
        -- video
        "mp4", "mkv", "webm", "avi", "amv", "mpg", "mpeg", "mpv",
        "m4v", "svi", "wmv",
        -- binaries, libs and packages assets
        "bin", "exe", "o", "so", "dll", "a", "dylib",
        "rgssad", "pak", "pdb", "bank", "ovl", "dat",
        "mdi", "ad", "dig", "pat", "lev", "mq", "mob",
        "pk3", "wad", "bak", "dbs", "pck", "x86_64",
        -- archives
        "zip", "rar", "tar", "gz",
        -- misc
        "rgs", "dat", "ani", "cur", "CurtainsStyle", "CopyComplete", "lst",
    }

    local function get_ignore_patterns()
        local tbl = {}
        for _, v in ipairs(file_ignores) do
            table.insert(tbl, "%." .. v .. "$")
            -- table.insert(tbl, "%." .. string.upper(v) .. "$")
        end
        return tbl
    end

    fzf.setup({
        "telescope",
        winopts = {
            -- -- Drawer mode
            -- width = 1,
            -- height = 0.25,
            -- row = 1,
            -- column = 0,
            border = require("theme").border_normal,
            preview = {
                -- default = "bat",
                border = "noborder",
                vertical = "down:15%",
                horizontal = "right:60%",
            },
        },
        fzf_opts = {
            ["--layout"] = "reverse",
        },
        fzf_colors = {
            ["fg"]      = { "fg", "CursorLine" },
            ["bg"]      = { "bg", "Normal" },
            ["hl"]      = { "fg", "Comment" },
            ["fg+"]     = { "fg", "Normal" },
            ["bg+"]     = { "bg", "Normal" },
            ["hl+"]     = { "fg", "Statement" },
            ["info"]    = { "fg", "PreProc" },
            ["prompt"]  = { "fg", "Conditional" },
            ["pointer"] = { "fg", "Exception" },
            ["marker"]  = { "fg", "Keyword" },
            ["spinner"] = { "fg", "Label" },
            ["header"]  = { "fg", "Comment" },
            ["gutter"]  = { "bg", "Normal" },
        },
        file_ignore_patterns = get_ignore_patterns(),
        files = {
            prompt = "> ",
            cwd_prompt = false
        },
        git = {
            files    = { prompt = "> " },
            status   = { prompt = "> " },
            commits  = { prompt = "> " },
            bcommits = { prompt = "> " },
            branches = { prompt = "> " },
            stash    = { prompt = "> " },
        },
        grep = {
            prompt       = "> ",
            input_prompt = "> ",
        },
        args           = { prompt = "> " },
        oldfiles       = { prompt = "> " },
        buffers        = { prompt = "> " },
        tabs           = { prompt = "> " },
        lines          = { prompt = "> " },
        blines         = { prompt = "> " },
        tags           = { prompt = "> " },
        btags          = { prompt = "> " },
        colorschemes   = { prompt = "> " },
        keymaps        = { prompt = "> " },
        quickfix       = { prompt = "> " },
        quickfix_stack = { prompt = "> " },
        lsp = {
            prompt       = "> ",
            code_actions = { prompt = "> " },
            finder       = { prompt = "> " },
        },
        diagnostics = { prompt = "> " }
    })

    fzf.register_ui_select()

    noremap("n", "<leader>ff", "<cmd>FzfLua files<cr>"           , { desc = "[F]ind [F]ile" } )
    noremap("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>"        , { desc = "[F]ile [R]ecent" } )
    noremap("n", "<leader>fg", "<cmd>FzfLua grep_project<cr>"    , { desc = "[F]ile [G]rep" } )
    noremap("n", "<leader>fa", "<cmd>FzfLua git_files<cr>"       , { desc = "[F]ile [A]ll" } )
    noremap("n", "<leader>fp", "<cmd>FzfLuaProjects<cr>"         , { desc = "[F]ind [P]roject" } )
    noremap("n", "<leader>fm", "<cmd>FzfLua marks<cr>"           , { desc = "[F]ind [M]arks" } )
    noremap("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>"         , { desc = "[F]ind [K]eys" } )
    noremap("n", "<leader>fl", "<cmd>FzfLua blines<cr>"          , { desc = "[F]ile search [L]ines" })
    noremap("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "[C]ode [A]ctions" } )
else
    local noremap = require("remap").noremap
    if vim.fn.executable("rg") ~= 1 or vim.g.use_search_find then
        noremap("n", "<leader>ff", [["<cmd>silent sfind! " . input("What")]], { desc = "[F]ind [F]iles" })
        noremap("n", "<leader>fg", [["<cmd>silent lgrep! " . input("What") . " | lopen"]], { desc = "[F]ile [G]rep", expr = true })
        return
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
            vim.notify("Must provide pattern", vim.log.levels.ERROR); return
        end
        local f = vim.system({ "bash", "-c", "rg --files . | rg -i '" .. i .. "'" }, { text = true }):wait()
        if #f.stdout == 0 then
            vim.notify("Failed to find " .. i, vim.log.levels.ERROR)
        else
            local lines = vim.split(f.stdout, "\n")
            fill_loc(lines, "File Finder", function(l) return "filepath:" .. l end)
        end
        -- vim.print(f)
    end, { desc = "[F]ind [F]iles" })

    noremap("n", "<leader>fg", function()
        local i = vim.fn.input("Search pattern: ")
        if #i == 0 then
            vim.notify("Must provide pattern", vim.log.levels.ERROR); return
        end
        local f = vim.system({ "rg", "-i", "--no-heading", "--line-number", i },
            { text = true }):wait()
        -- vim.print(f)
        if f.code == 0 then
            local lines = vim.split(f.stdout, "\n")
            fill_loc(lines, "File Grep")
        else
            vim.notify("Failed to find pattern " .. i, vim.log.levels.ERROR)
        end
    end, { desc = "[F]ile [G]rep" })

    noremap("n", "<leader>fr", function()
        fill_loc(vim.v.oldfiles, "Old Files", function(l) return 'filepath:' .. l end)
    end, { desc = "[F]ind [R]ecent" })

    noremap("n", "<leader>ft", function()
        local f = vim.system(
        { "rg", "--no-heading", "--type", "all", "--line-number", ".*(?:TODO|FIXME|TEMP|REFACTOR|REVIEW|HACK|BUG):.*" },
            { text = true }):wait()
        if #f.stdout == 0 then
            vim.notify("No todo's found", vim.log.levels.ERROR)
        else
            local lines = vim.split(f.stdout, "\n")
            fill_loc(lines, "Todo List")
        end
        -- vim.print(f)
    end, { desc = "[F]ind [T]odo" })
end
