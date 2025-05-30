return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			explorer = {
				enabled = true,
				layout = {
					cycle = false,
				},
			},
			picker = {
				enabled = true,
				matchers = {
					frecency = true,
					cwd_bonus = true,
				},
				formatters = {
					file = {
						filename_first = false,
						filename_only = false,
						icon_width = 2,
					},
				},
			},
		},
		keys = {
			-- git
			{
				"<leader>lg",
				function()
					require("snacks").lazygit()
				end,
				desc = "LazyGit",
			},
			{
				"<leader>gl",
				function()
					require("snacks").lazygit.log()
				end,
				desc = "LazyGit Logs",
			},
			{
				"<leader>gsw",
				function()
					require("snacks").picker.git_branches({ layout = "select" })
				end,
				desc = "Switch Git Branch",
			},

			{
				"<leader>rN",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Rename Current File",
			},

			-- TODO: maybe swith to snacks Picker instead of Telescope
		},
	},
}
