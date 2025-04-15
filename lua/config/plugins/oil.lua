return {
	"stevearc/oil.nvim",
	opts = {},
	lazy = false,
	dependencies = {
		{
			"echasnovski/mini.icons",
			opts = {},
		},
	},

	config = function()
		CustomOilBar = function()
			local path = vim.fn.expand("%")
			path = path:gsub("oil://", "")

			return " " .. vim.fn.fnamemodify(path, ":.")
		end

		require("oil").setup({
			win_options = {
				winbar = "%{v:lua.CustomOilBar()}",
			},
		})

		vim.keymap.set("n", "<space>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
