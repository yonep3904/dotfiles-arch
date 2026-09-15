vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 表示
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- インデント
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 検索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- 操作
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.clipboard = "unnamedplus"

-- ファイルと履歴
vim.opt.undofile = true
vim.opt.swapfile = false
