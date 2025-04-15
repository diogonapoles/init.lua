local opt = vim.opt
local g = vim.g
local indentation = 2

g.mapleader = " "
g.maplocalleader = "\\"

-- clipboard
opt.clipboard = "unnamedplus"

-- search
opt.smartcase = true
opt.ignorecase = true

-- personal
opt.title = true
opt.number = true
opt.relativenumber = true
opt.inccommand = "split"
opt.signcolumn = "yes"
opt.swapfile = false
opt.wrap = true
opt.linebreak = true

-- windows
opt.splitbelow = true
opt.splitright = true

-- indentation
opt.tabstop = indentation
opt.shiftwidth = indentation
