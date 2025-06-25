return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 900,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"css",
					"diff",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
                    "hcl",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
                    "terraform",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				auto_install = true,
				indent = { enable = true },
				highlight = { enable = true },
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
			},
		},
		event = { "BufAdd", "BufNewFile", "BufReadPre" },
		config = true,
		opts = {
			opts = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
			},
			aliases = {},
		},
	},
}
