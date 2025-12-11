---@diagnostic disable: undefined-field
-- from: https://github.com/Bekaboo/nvim

-- prevent double execution
if vim.g.intro_executed ~= nil then return end
vim.g.intro_executed = true

-- Disable default intro message
vim.opt.shortmess:append('I')

if vim.fn.argc() > 0 then
    return
end

-- Set eventignore to avoid triggering plugin lazy-loading handlers
local eventignore = vim.go.eventignore
vim.go.eventignore = 'all'

local logo = 'S T E L L A R'

---@class intro_chunk_t
---@field text string
---@field hl string
---@field len integer? byte-indexed text length
---@field width integer? display width of text

---@class intro_line_t
---@field chunks intro_chunk_t[]
---@field text string?
---@field width integer?
---@field offset integer?

vim.cmd([[
    hi CustomIntroDim gui=underline guifg=NvimDarkGrey4
]])

if vim.version().minor == 12 then vim.notify("plugin/intro.lua(4): error: MIGRATE TO vim.pack", vim.log.levels.ERROR); return end
local plugin_text = nil
if vim.g.plugins_enabled then
    --                                  Current date is 22.22.22
    plugin_text = { chunks = {{ text = "Extension status - ON:" .. #(require("lazy").plugins()), hl = "CustomIntroDim" }} }
else
    plugin_text = { chunks = {{ text = "Extension status - OFF:0", hl = "NonText"  }} }
end

---Lines of text and highlight groups to display as intro message
---@type intro_line_t[]
local lines = {
    { chunks = {
        { text = string.format('%s', logo), hl = 'Normal' },
        { text = ' :: N V I M',            hl = 'NonText' },
    }, },
    { chunks = {
        { text = string.format("Current date is %s", os.date('!%d.%m.%y', os.time())), hl = 'NonText', },
    }, },
    plugin_text
}

---Window configuration for the intro message floating window
---@type vim.api.keyset.win_config
local win_config = {
    width = 0,
    height = #lines,
    relative = 'editor',
    style = 'minimal',
    focusable = false,
    noautocmd = true,
    zindex = 1,
}

---Calculate the width, offset, concatenated text, etc.
for _, line in ipairs(lines) do
    if line == nil then goto continue end
    line.text = ''
    line.width = 0
    for _, chunk in ipairs(line.chunks) do
        chunk.len = #chunk.text
        chunk.width = vim.fn.strdisplaywidth(chunk.text)
        line.text = line.text .. chunk.text
        line.width = line.width + chunk.width
    end
    if line.width > win_config.width then
        win_config.width = line.width
    end
    ::continue::
end

for _, line in ipairs(lines) do
    line.offset = math.floor((win_config.width - line.width) / 2)
end

-- Decide the row and col offset of the floating window,
-- return if no enough space
win_config.row = math.floor((vim.go.lines - vim.go.ch - win_config.height) / 2)
win_config.col = math.floor((vim.go.columns - win_config.width) / 2)
if win_config.row < 4 or win_config.col < 8 then
    -- Restore &eventignore before exit
    vim.go.eventignore = eventignore
    return
end

-- Create the scratch buffer to display the intro message
local buf = vim.api.nvim_create_buf(false, true)
vim.bo[buf].bufhidden = 'wipe'
vim.bo[buf].buftype = 'nofile'
vim.bo[buf].swapfile = false
vim.api.nvim_buf_set_lines(
    buf,
    0,
    -1,
    false,
    vim.tbl_map(function(line)
        return string.rep(' ', line.offset) .. line.text
    end, lines)
)

-- Apply highlight groups
local ns = vim.api.nvim_create_namespace('NvimIntro')
for linenr, line in ipairs(lines) do
    local chunk_offset = line.offset
    for _, chunk in ipairs(line.chunks) do
        vim.highlight.range(
            buf,
            ns,
            chunk.hl,
            { linenr - 1, chunk_offset },
            { linenr - 1, chunk_offset + chunk.len },
            {}
        )
        chunk_offset = chunk_offset + chunk.len
    end
end

-- Open the window to show the intro message
local win = vim.api.nvim_open_win(buf, false, win_config)
vim.wo[win].winhl = 'NormalFloat:Normal,Search:,Incsearch:'

-- Clear the intro when the user does something
vim.api.nvim_create_autocmd({
    'BufModifiedSet',
    'BufReadPre',
    'CursorMoved',
    'StdinReadPre',
    'InsertEnter',
    'TermOpen',
    'TextChanged',
    'VimResized',
    'WinEnter',
}, {
    once = true,
    group = vim.api.nvim_create_augroup('NvimIntro', {}),
    callback = function(info)
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        vim.api.nvim_del_augroup_by_id(info.group)
        return true
    end,
})

-- Restore &eventignore before exit
vim.go.eventignore = eventignore
