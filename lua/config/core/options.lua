local opt = vim.opt
local g = vim.g
local indentation = 2

g.mapleader = " "
g.maplocalleader = "\\"

-- clipboard
opt.clipboard:append("unnamedplus")

-- search
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true

-- personal
opt.title = true
opt.number = true
opt.relativenumber = true
opt.swapfile = false
opt.linebreak = true

-- look
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 8
opt.signcolumn = "yes"

-- windows
opt.splitright = true
opt.splitbelow = true

-- indentation
opt.tabstop = indentation
opt.softtabstop = indentation
opt.shiftwidth = indentation
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
