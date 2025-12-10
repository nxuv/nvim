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
    sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' }, { name = 'path', option = { pathMappings = { ["@"] = "${folder}/src" } } } }),
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

            if     entry.menu == "cmdline"  then entry.menu = "<CM>"
            elseif entry.menu == "buffer"   then entry.menu = "<BF>"
            elseif entry.menu == "nvim_lsp" then entry.menu = "<LS>"
            else   entry.menu = "<" .. entry.menu .. ">" end

            return entry
        end
    },
    view = { entries = { name = 'custom', selection_order = 'near_cursor' } }
})


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
