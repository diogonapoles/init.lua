return {
	{
		"echasnovski/mini.nvim",
		enabled = true,

		config = function()
			local statusline = require("mini.statusline")
			local ai = require("mini.ai")

			statusline.setup({
				use_icons = true,
			})

			ai.setup()
		end,
	},
}
