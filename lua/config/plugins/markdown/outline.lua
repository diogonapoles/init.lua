return {
	"hedyhli/outline.nvim",
	lazy = true,
	ft = "markdown",
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = {
		symbol_folding = {
			autofold_depth = false,
		},
	},
}
