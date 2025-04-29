return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local tree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		tree.setup({
			hijack_cursor = false,

			filters = {
				custom = { ".DS_Store" },
				dotfiles = true,
			},

			git = {
				ignore = false,
			},

			renderer = {
				indent_markers = {
					enable = true,
				},
			},

			view = {
				width = 30,
				relativenumber = true,
			},
		})

		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
	end,
}
