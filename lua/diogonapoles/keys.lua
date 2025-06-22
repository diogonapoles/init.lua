local keymap = vim.keymap

-- move lines
keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

-- navigate splits
keymap.set("", "<C-h>", "<C-w>h")
keymap.set("", "<C-j>", "<C-w>j")
keymap.set("", "<C-k>", "<C-w>k")
keymap.set("", "<C-l>", "<C-w>l")

-- spell checking
keymap.set("n", "<leader>c", function()
	vim.wo.spell = not vim.wo.spell
end, { desc = "Toggle spell checking" })

-- others
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select full file" })
