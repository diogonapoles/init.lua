return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	config = function()
		local set = vim.keymap.set

		local builtin = require("telescope.builtin")
		set("n", "<space>ff", builtin.find_files, { desc = "Find files on the current directory" })
		set("n", "<space>fs", builtin.live_grep, { desc = "Find string" })

		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				wrap_results = true,
			},

			find_files = {
				hidden = true,
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
