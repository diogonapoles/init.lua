return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	config = function()
		local set = vim.keymap.set
		local telescope = require("telescope")

		telescope.setup({
			find_files = {
				hidden = true,
				theme = "ivy",
			},

			extensions = {
				wrap_results = true,
				fzf = {},
			},
		})
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		set("n", "<space>ff", builtin.find_files, { desc = "Find files on the current directory" })
		set("n", "<space>fs", builtin.live_grep, { desc = "Find string" })
	end,
}
