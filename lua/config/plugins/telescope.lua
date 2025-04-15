return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	config = function()
		local set = vim.keymap.set
		require("telescope").setup({
			extensions = {
				wrap_results = true,
			},
		})

		local builtin = require("telescope.builtin")

		set("n", "<space>ff", builtin.find_files, { desc = "Find files on the current directory" })
		set("n", "<space>fs", builtin.live_grep, { desc = "Find string" })
	end,
}
