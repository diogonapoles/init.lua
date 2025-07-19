vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.relativenumber = true
vim.o.mouse = 'a' -- mouse mode

vim.o.showmode = false -- hide the current mode

-- sync clipboard between OS and Neovim after UiEnter
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true -- indent
vim.o.undofile = true -- undo history

-- case-insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split' -- preview substitutions

-- signcolumn on by default
vim.o.signcolumn = 'yes'

vim.o.updatetime = 250 -- decrease update time
vim.o.timeoutlen = 300 -- decrease mapped sequence wait time

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.cursorline = true -- show which line your cursor is
vim.o.scrolloff = 10 -- number of screen lines to keep above and below the cursor

-- confirmations on :q
vim.o.confirm = true
