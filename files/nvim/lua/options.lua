vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.completeopt = "menuone,popup,noinsert,noselect"

vim.opt.grepprg = "rg --vimgrep --smart-case --sort=path"

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
