-- nvim settings

if vim.g.vim_distro == "monolith.nvim" then
    vim.opt.cmdheight = 0
else
    vim.loader.enable()
    vim.opt.cmdheight = 1
    -- vim.opt.cmdheight = 0
end


vim.o.background    = "dark" -- or "light" for light mode
vim.o.clipboard     = "unnamedplus" -- set clipboard to be system
vim.o.mouse         = "nvi" -- normal, visual, insert
vim.o.mousemodel    = "extend" -- sets right mouse click to extend selection
vim.o.signcolumn    = "no" -- removes gutter
vim.o.virtualedit   = "onemore,block" -- allow to go a single char after eol and allow better C-v
vim.o.linebreak     = true -- wraps lines by words (softbreak)
vim.o.cursorlineopt = "screenline"
vim.o.laststatus    = 3
vim.o.path          = vim.o.path .. ",**"
vim.o.completeopt   = "menuone,menu,longest,preview"
vim.o.foldmethod    = 'manual'
-- vim.o.foldmethod            = 'expr'
-- vim.o.scrolloff             = 7

vim.opt.shortmess      = "filnxtToOF"
vim.opt.autoread       = true -- default value, autoreload file
vim.opt.colorcolumn    = '0' -- 80 symbol split
vim.opt.cursorcolumn   = false -- show cursor column
vim.opt.cursorline     = true -- cursor line hightlight
vim.opt.expandtab      = true -- use spaces instead of tabs
vim.opt.hlsearch       = true -- Set highlight on search
vim.opt.ignorecase     = true -- Case insensitive searching unless /C or capital in search
vim.opt.inccommand     = "split" -- shows %s/// in split
vim.opt.joinspaces     = false -- No double spaces with join after a dot
vim.opt.number         = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.shiftwidth     = 4 -- shift 4 spaces when tab
vim.opt.showmatch      = true -- highlight matching brackets
vim.opt.showmode       = false -- no --INSERT--
vim.opt.smartcase      = true -- Smart case
vim.opt.smartindent    = true -- autoindent new lines
vim.opt.so             = 0 -- cursor moves normally (no boundary)
vim.opt.splitbelow     = true -- horizontal split down
vim.opt.splitright     = true -- vertical split right
vim.opt.tabstop        = 4 -- 1 tab == 4 spaces
vim.opt.undofile       = true -- Save undo history
vim.opt.updatetime     = 300 -- speeds up autocompletion
vim.opt.wrap           = false -- removes wrapping of lines
vim.opt.termguicolors  = true
-- vim.o.conceallevel = 2
-- vim.opt.shada               = "!,'20,f1,<50,s10,h" -- oldfiles config

local backup_dir = vim.fn.stdpath('data').."/.cache"
vim.opt.backup = true                         -- make backups before writing
vim.opt.writebackup = true                    -- Make backup before overwriting the current buffer
vim.opt.backupcopy = 'yes'                    -- Overwrite the original backup file
vim.opt.directory = backup_dir .. '/swap'     -- directory to place swap files in
vim.opt.backupdir = backup_dir .. '/backedUP' -- where to put backup files
vim.opt.undodir = backup_dir .. '/undos'      -- where to put undo files
vim.opt.viewdir = backup_dir .. '/view'       -- where to store files for :mkview
vim.opt.shada = "'100,<50,f50,n"..backup_dir.."/shada/shada"

-- netrw config
-- vim.g.netrw_cursor          = 5
-- vim.g.netrw_browse_split    = 4 -- make cr behave open vsplit prev
-- vim.g.netrw_list_hide       = [[\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_banner          = 0
vim.g.netrw_keepdir         = 1
vim.g.netrw_keepj           = ''
vim.g.netrw_altv            = 1
vim.g.netrw_list_hide       = "^\\.\\.\\=/\\=$"
vim.g.netrw_liststyle       = 0 -- 3 =  show as tree
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_clipboard       = 0

vim.g["lsp-timeout-config"] = {
    stopTimeout  = 1000 * 60 * 5, -- ms, timeout before stopping all LSP servers
    startTimeout = 1000 * 10,     -- ms, timeout before restart
    silent       = true           -- true to suppress notifications
}

-- don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

vim.cmd([[set guicursor=n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20]])

-- vim.cmd [[language en_US.UTF-8]]
vim.cmd([[filetype indent plugin on]])
vim.cmd([[syntax enable]])

-- Enable plugins and load plugin for the detected file type.
vim.cmd([[filetype plugin on]])
-- Enable Omnicomplete features
vim.cmd([[set omnifunc=syntaxcomplete#Complete]])

vim.cmd("set errorformat^=filepath:%f")

