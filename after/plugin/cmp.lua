if not require("modules").can_load("cmp") then return end

local cmp = require("cmp")

local function reformatString(str, minwidth, maxwidth, ellipsis_char)
    if vim.fn.strchars(str) > maxwidth then
        return vim.fn.strcharpart(str, 0, maxwidth) .. (ellipsis_char ~= nil and ellipsis_char or "")
    else
        return str .. string.rep(' ', minwidth - vim.fn.strchars(str))
    end
end

local confirm_or_cr = cmp.mapping(function (fallback)
    if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, })
    else fallback() end
end, { "i" })

local confirm_or_escape = cmp.mapping(function (fallback)
    if cmp.visible() and cmp.get_active_entry() then
        cmp.complete(); cmp.close(); vim.cmd("stopinsert");
    else fallback() end
end, { "i" })

local next_item = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
local prev_item = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })

cmp.setup({
    mapping = {
        ['<C-e>'] = cmp.mapping.abort(), ['<Esc>'] = confirm_or_escape, ["<CR>"] = confirm_or_cr,
        ["<C-n>"] = next_item, ["<Tab>"] = next_item, ["<C-p>"] = prev_item, ["<S-Tab>"] = prev_item,
        ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { "i", "c" }),
    },
    -- { name = "nvim_lsp", entry_filter = function(e, _) return cmp.lsp.CompletionItemKind.Snippet ~= e:get_kind() end }
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'tags' },
        { name = 'dynamic' },
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'path' },
    }),
    window = {
        completion = {
            col_offset = -3,
            border = "none",
            scrollbar = false,
        },
        documentation = { border = "single", }
    },
    -- experimental = { ghost_text = "Comment" },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(p_entry, p_vim_item)
            local entry = p_vim_item

            entry.menu = p_entry.source.name
            entry.abbr = reformatString("" .. entry.abbr, 25, 50, '...')
            entry.kind = "[" .. entry.kind .. "]"

            if     entry.menu == "cmdline"  then entry.menu = "<CMD>"
            elseif entry.menu == "buffer"   then entry.menu = "<BUF>"
            elseif entry.menu == "nvim_lsp" then entry.menu = "<LSP>"
            elseif entry.menu == "tags"     then entry.menu = "<TAG>"
            elseif entry.menu == "dynamic"  then entry.menu = "<FNC>"
            elseif entry.menu == "calc"     then entry.menu = "<CAL>"
            else   entry.menu = "<" .. entry.menu .. ">" end

            return entry
        end
    },
    view = { entries = { name = 'custom', selection_order = 'near_cursor' } }
})

--[[
TODO: look into writing own completion
    https://github.com/nat-418/cmp-color-names.nvim/blob/main/lua/cmp-color-names.lua
    https://github.com/jcha0713/cmp-tw2css/blob/main/lua/cmp-tw2css/items.lua
]]

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
    view = { entries = { name = "custom", selection_order = "near_cursor" } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources( { { name = 'path' } }, { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }),
    view = { entries = { name = "custom", selection_order = "near_cursor" } }
})

local function dynamic_text(label, text)
    return {
        label = label,
        resolve = true,
        insertText = function() return text end
    }
end

require("cmp_dynamic").register({
    { label = "~date", resolve = true, insertText = function()
        return os.date("%Y.%m.%d")
    end },
    { label = "~time", resolve = true, insertText = function()
        return os.date("%H:%M:%S")
    end },
    dynamic_text("~tree-sub", "├── "),
    dynamic_text("~tree-nop", "│   "),
    dynamic_text("~tree-end", "└── "),

    dynamic_text("~make-default", ".DEFAULT_GOAL := all\n.MAIN: all"),
    -- Doesn't really work, executes as soon as you hover,
    -- when popup is closed it stops trying to autocomplete.
    -- Basically doesn't work at all.
    -- { label = "~test", resolve = true, insertText = function()
    --     local a  = vim.fn.confirm("Your choes mr freemon", "Yes\nNo\nMe\nA")
    --     return os.date("%H:%M:%S") .. a
    -- end },
})

