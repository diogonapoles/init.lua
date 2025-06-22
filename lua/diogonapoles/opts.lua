local opt = vim.opt
local g = vim.g
local indent = 4

-- leader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- clipboard
opt.clipboard:append("unnamedplus")

-- file behavior
opt.fileformat = "unix"
opt.encoding = "utf-8"
opt.swapfile = false
opt.title = true

-- indentation
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = false
opt.linebreak = true

-- search
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

-- line numbers
opt.number = true
opt.relativenumber = true

-- window splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "topline"

-- spellcheck
opt.spelllang = "en_us,cjk"
opt.spelloptions = "camel"

