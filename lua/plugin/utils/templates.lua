-- Templates
local M = {}

local function split(text, delimiter)
    local result               = {}
    local from                 = 1
    local delim_from, delim_to = text:find(delimiter, from)
    while delim_from do
        table.insert(result, text:sub(from, delim_from - 1))
        from                 = delim_to + 1
        delim_from, delim_to = text:find(delimiter, from)
    end
    table.insert(result, text:sub(from))
    return result
end

local data_path = vim.fn.stdpath("data")

local function listdir()
    local ls = {}
    ---@diagnostic disable-next-line: undefined-global
    if jit.os == "Linux" then
        for dir in io.popen("ls -pa '" .. data_path .. "/templates'" .. " | grep -v /"):lines() do
            table.insert(ls, dir)
        end
    end
    ---@diagnostic disable-next-line: undefined-global
    if jit.os == "Windows" then
        for dir in io.popen('dir "' .. data_path .. '\\templates "' .. " /b "):lines() do
            table.insert(ls, dir)
        end
    end
    return ls
end

local function insert_file(fname)
    local f = io.open(data_path .. "/templates/" .. fname, "r")
    if f == nil then return "" end
    local text
    text = f:read("*a"):gsub("\r\n?", "\n")
    f:close()
    vim.api.nvim_put(split(text, '\n'), "", false, true)
end

M.paste_template = function(args)
    insert_file(args.fargs[1])
end

M.autocomplete = function(arg)
    local list = listdir()
    return vim.tbl_filter(function(s)
        return string.match(s, '^' .. arg)
    end, list)
end

-- - ---------------------------------------------------------------------------- -

local can_load = require("vim.modules").can_load

if not can_load("fzf-lua") then return M end

local fzf = require("fzf-lua")

M.select = function()
    fzf.fzf_exec(listdir() , {
        actions = {
            ['default'] = {
                fn = function(sel, opts)
                    insert_file(sel[1])
                end
            }
        }
    })
end

return M

