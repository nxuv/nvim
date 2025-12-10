local noremap = require("remap").noremap
local utils   = require("utils")

-- - ---------------------------------------------------------------------------- -
-- -                       Window navigation and management                       -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<A-h>",     "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-l>",     "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-k>",     "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-j>",     "<C-w>j", { desc = "Focuses lower pane" })
noremap("n", "<A-left>",  "<C-w>h", { desc = "Focuses pane to the left" })
noremap("n", "<A-right>", "<C-w>l", { desc = "Focuses pane to the right" })
noremap("n", "<A-up>",    "<C-w>k", { desc = "Focuses upper pane" })
noremap("n", "<A-down>",  "<C-w>j", { desc = "Focuses lower pane" })

noremap("n", "<leader>ss", "<CMD>split<CR>", { desc = "[S]plit [S]horisontaly" })
noremap("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "[S]plit [V]ertically" })

noremap("n", "<leader>gg", "<CMD>tab sp<CR>", { desc = "Opens current buffer in new tab" })

-- - ---------------------------------------------------------------------------- -
-- -                                    Scroll                                    -
-- - ---------------------------------------------------------------------------- -

noremap('' , '<S-ScrollWheelUp>',   '3zh', { desc = "Scrolls right" })
noremap('' , '<S-ScrollWheelDown>', '3zl', { desc = "Scrolls left" })
noremap('i', '<S-ScrollWheelUp>',   '<C-o>3zh', { desc = "Scrolls right" })
noremap('i', '<S-ScrollWheelDown>', '<C-o>3zl', { desc = "Scrolls left" })

-- - ---------------------------------------------------------------------------- -
-- -                                     Misc                                     -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<C-i>", "<C-i>",  { desc = "Jump motion fix" })
noremap("n", "U", "V:s/\\s\\+/\\r/g<cr>:nohl<cr>", { desc = "Unjoin lines (don't need really linewise undo)" })

-- - ---------------------------------------------------------------------------- -
-- -                              Buffer navigation                               -
-- - ---------------------------------------------------------------------------- -

noremap('n', "<Home>", utils.lineHome, { desc = "Goes to beginning of line" })
noremap('i', "<Home>", utils.lineHome, { desc = "Goes to beginning of line" })
noremap('v', "<Home>", utils.lineHome, { desc = "Goes to beginning of line" })
noremap('n', "<End>",  utils.lineEnd,  { desc = "Goes to end of line" })
noremap('i', "<End>",  utils.lineEnd,  { desc = "Goes to end of line" })
noremap('v', "<End>",  utils.lineEnd,  { desc = "Goes to end of line" })

noremap("v", "*", '""y/<C-r>"<cr>', { desc = "Search for selected string" })
noremap("v", "#", '""y?<C-r>"<cr>', { desc = "Search for selected string" })
noremap("n", "n", "nzzzv", { desc = "Keep search centered" })
noremap("n", "N", "Nzzzv", { desc = "Keep search centered" })

-- - ---------------------------------------------------------------------------- -
-- -                                 Text editing                                 -
-- - ---------------------------------------------------------------------------- -

noremap("n", ">", ">>", { desc = "Indent right" })
noremap("n", "<", "<<", { desc = "Indent left" })

noremap("v", ">", ">gv", { desc = "Indent right and reselect" })
noremap("v", "<", "<gv", { desc = "Indent left and reselect" })

noremap("n", "<Del>", function() utils.delete_char(0) end, { desc = "Delete but into black hole" })
-- noremap("i", "<Del>", function() utils.delete_char(0) end, { desc = "Delete but into black hole" })
noremap("n", "<BS>",  function() utils.delete_char(1) end, { desc = "Deletes into black hole" });
-- noremap("i", "<BS>",  function() utils.delete_char(1) end, { desc = "Deletes into black hole" });
noremap("v", "<BS>",  '"_x', { desc = "Deletes into black hole" });
noremap("v", "<Del>", '"_x', { desc = "Deletes into black hole" });

noremap("i", "<A-k>", "<esc>ddkPi", { desc = "Moves line up" })
noremap("i", "<A-j>", "<esc>ddpi", { desc = "Moves line down" })
noremap("i", "<A-up>", "<esc>ddkPi", { desc = "Moves line up" })
noremap("i", "<A-down>", "<esc>ddpi", { desc = "Moves line down" })

noremap("v", "<A-j>", [['xp`[' . getregtype()[0] . '`]']],    { desc = "Moves visual lines down", expr = true })
noremap("v", "<A-up>", [['xkP`[' . getregtype()[0] . '`]']],  { desc = "Moves visual lines up", expr = true })
noremap("v", "<A-down>", [['xp`[' . getregtype()[0] . '`]']], { desc = "Moves visual lines down", expr = true })
noremap("v", "<A-k>", [['xkP`[' . getregtype()[0] . '`]']],   { desc = "Moves visual lines up", expr = true })

-- - ---------------------------------------------------------------------------- -
-- -                              Buffer management                               -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>fs", "<cmd>exe v:count ? v:count .. 'b' : 'b' .. (bufloaded(0) ? '#' : 'n')<cr>", { desc = "[F]ile [S]wap" })

noremap("n", "<leader>fe", "<cmd>enew<cr>",   { desc = "[F]ile [E]dit" })
noremap("n", "<leader>q",  "<cmd>q!<cr>",      { desc = "[Q]uits buffer" })
noremap("n", "<leader>w",  "<cmd>w!<cr>", { desc = "[W]rites buffer" })

-- - ---------------------------------------------------------------------------- -
-- -                               Quick navigation                               -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>cd", utils.cd_filedir, { desc = "[C]hanges [D]irectory to current file" })
noremap("n", "<leader>ce", "<cmd>edit $MYVIMRC <bar> tcd %:h<cr>", { desc = "[C]onfig [E]dit" })


-- - ---------------------------------------------------------------------------- -
-- -                                 Programming                                  -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>co", "<cmd>copen<cr>", { desc = "[C][O]pen" })
noremap("n", "]c", "<cmd>cnext<cr>",         { desc = "Go next quickfix" })
noremap("n", "[c", "<cmd>cprev<cr>",         { desc = "Go prev quickfix" })
noremap("n", "]C", "<cmd>clast<cr>",         { desc = "Go last quickfix" })
noremap("n", "[C", "<cmd>cfirst<cr>",        { desc = "Go first quickfix" })

noremap("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "[L][O]pen" })
noremap("n", "]l", "<cmd>lnext<cr>",         { desc = "Go next loclist" })
noremap("n", "[l", "<cmd>lprev<cr>",         { desc = "Go prev loclist" })
noremap("n", "]L", "<cmd>llast<cr>",         { desc = "Go last loclist" })
noremap("n", "[L", "<cmd>lfirst<cr>",        { desc = "Go first loclist" })

noremap("n", "]b", "<cmd>bnext<cr>",         { desc = "Go to next buffer" })
noremap("n", "[b", "<cmd>bprevious<cr>",     { desc = "Go to prev buffer" })
noremap("n", "]B", "<cmd>blast<cr>",         { desc = "Go to first buffer" })
noremap("n", "[B", "<cmd>bfirst<cr>",        { desc = "Go to last buffer" })
-- noremap("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

noremap("n", "<leader>cr", utils.uncomment_line, { desc = "Remove comment line" })
noremap("v", "<leader>cr", utils.uncomment_box,  { desc = "Remove comment box" })
noremap("n", "<leader>cl", utils.comment_sep,    { desc = "Create comment separator" })
noremap("n", "<leader>cb", utils.comment_line,   { desc = "Create comment line" })
noremap("v", "<leader>cb", utils.comment_box,    { desc = "Create comment box" })

-- i want only errors here
noremap("n", "]e", function() vim.diagnostic.jump({count =  1, float = true, severity = vim.diagnostic.severity.ERROR}) end)
noremap("n", "[e", function() vim.diagnostic.jump({count = -1, float = true, severity = vim.diagnostic.severity.ERROR}) end)
-- remap so it immediately opens it in float
noremap("n", "]d", function() vim.diagnostic.jump({count =  1, float = true}) end)
noremap("n", "[d", function() vim.diagnostic.jump({count = -1, float = true}) end)

-- - ---------------------------------------------------------------------------- -
-- -                                  Remapping                                   -
-- - ---------------------------------------------------------------------------- -

noremap("n", "gx", utils.open_link_norm, { desc = "[G]oes into link with [X]DG-OPEN" })
noremap("v", "gx", utils.open_link_vis,  { desc = "[G]oes into link with [X]DG-OPEN" })

-- - ---------------------------------------------------------------------------- -
-- -                                 Empty maps                                   -
-- - ---------------------------------------------------------------------------- -

noremap("v", "<S-down>", "<down>", { desc = "Prevent buffer scroll" })
noremap("v", "<S-up>",   "<up>",   { desc = "Prevent buffer scroll" })

-- - ---------------------------------------------------------------------------- -
-- -                                 Quick config                                 -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>ow", "<cmd>Wrap<cr>",  { desc = "Toggle [O]ption - [W]rap" })
noremap("n", "<leader>os", "<cmd>Spell<cr>", { desc = "Toggle [O]ption - [S]pell" })

-- - ---------------------------------------------------------------------------- -
-- -                                   Terminal                                   -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>cv", ":vsp term://$SHELL<cr>:setlocal norelativenumber<cr>:setlocal nonumber<cr>", { desc = "[C]onsole [V]split" })
noremap("n", "<leader>cs",  ":sp term://$SHELL<cr>:setlocal norelativenumber<cr>:setlocal nonumber<cr>", { desc = "[C]onsole [S]plit" })
noremap("n", "<leader>ct",     ":term<cr>:setlocal norelativenumber<cr>:setlocal nonumber<cr>", { desc = "[C]urrent [T]erminal" })

-- TODO: figure out better way
noremap("t", "<c-v><c-v>", [[<c-\><c-n>]], { desc = "Exits terminal insert mode" })

-- - ---------------------------------------------------------------------------- -
-- -                                Code execution                                -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>xb", "yy2o<ESC>kpV:!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })
noremap("v", "<leader>xb", "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!/bin/bash<CR>", { desc = "[E]xecute [B]ash and paste" })
noremap("n", "<leader>xsl", "<cmd>vsplit /tmp/nvim-scratchpad.lua<cr><cmd>w<cr>", { desc = "E[x]ecute [S]cratch [L]ua" })

-- - ---------------------------------------------------------------------------- -
-- -                                 Textobjects                                  -
-- - ---------------------------------------------------------------------------- -

noremap("x", "il", "^og_",          { desc = "[I]n [L]ine text object" })
noremap("x", "al", "0o$",           { desc = "[A]round [L]ine text object" })
noremap("o", "il", ":norm vil<cr>", { desc = "[I]n [L]ine text object" })
noremap("o", "al", ":norm val<cr>", { desc = "[A]round [L]ine text object" })

noremap("x", "if", "gg0oG$",        { desc = "[I]n [F]ile" })
noremap("o", "if", ":norm vif<cr>", { desc = "[I]n [F]ile" })

noremap("o", "g$", ":norm vg$<cr>", { desc = "To end of line text object" })
noremap("o", "g_", ":norm vg_<cr>", { desc = "To last char in line text object" })
noremap("o", "^", ":norm v^<cr>",   { desc = "To first char in line text object" })
noremap("o", "0", ":norm v0<cr>",   { desc = "To start of line text object" })

-- - ---------------------------------------------------------------------------- -
-- -                                 Diff editing                                 -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>df", "/=======<cr><cmd>nohl<cr>zz", { desc = "[D]iff [F]ind" })
noremap("n", "<leader>dF", "?=======<cr><cmd>nohl<cr>zz", { desc = "[D]iff [F]ind backwards" })
noremap("n", "<leader>di", "mf/>>>>>>> <cr>mt?<<<<<<< <cr>mk'fV'tx'kdd<cmd>nohl<cr>", { desc = "[D]iff [I]ncomming" })
noremap("n", "<leader>do", "mf?<<<<<<< <cr>mt/>>>>>>> <cr>mk'fV'tx'kdd<cmd>nohl<cr>", { desc = "[D]iff [O]utgoing" })
noremap("n", "<leader>db", "dd?<<<<<<< <cr>dd/>>>>>>> <cr>dd<cmd>nohl<cr>", { desc = "[D]iff [K]eep both" })

-- - ---------------------------------------------------------------------------- -
-- -                                Tab navigation                                -
-- - ---------------------------------------------------------------------------- -

noremap("n", "]t", "<cmd>tabnext<cr>",     { desc = "Opens next tab" })
noremap("n", "[t", "<cmd>tabprevious<cr>", { desc = "Opens previous tab" })

noremap("n", "]T", "<cmd>tabfirst<cr>", { desc = "Moves tab right" })
noremap("n", "[T", "<cmd>tablast<cr>", { desc = "Moves tab left" })

-- - ---------------------------------------------------------------------------- -
-- -                              Session management                              -
-- - ---------------------------------------------------------------------------- -

noremap("n", "<leader>ks", "<cmd>mks! .vim-session<cr>", { desc = "M[K][S]ession" })
noremap("n", "<leader>kl", "<cmd>source .vim-session<cr>", { desc = "M[K]session [L]oad" })

-- - ---------------------------------------------------------------------------- -
-- -                                Tips and notes                                -
-- - ---------------------------------------------------------------------------- -

-- tip: o switches vis direction

-- '' - normal, visual, select, operator pending
-- n - normal
-- v - visual and select
-- s - select
-- x - visual
-- o - operator pending
-- ! - insert and command line
-- i - insert
-- l - insert, command line and lang arg
-- c - command mode
-- t - terminal

-- map to <nop> to disable

-- Goal is to slowly move away from all those "normie" shortcuts

