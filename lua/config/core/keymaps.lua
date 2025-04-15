local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select full file" })
--
-- move lines
keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

-- navigate splits 
keymap.set("n", "<c-j>", "<c-w><c-j>")
keymap.set("n", "<c-k>", "<c-w><c-k>")
keymap.set("n", "<c-l>", "<c-w><c-l>")
keymap.set("n", "<c-h>", "<c-w><c-h>")
