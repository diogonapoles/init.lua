return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		local function group_first(item)
			return item.group and 0 or 1
		end

		wk.setup({
			preset = "classic",
			delay = vim.o.timeoutlen,
			triggers = {
				{ "<auto>", mode = "nixso" },
			},
			title = true,
			title_pos = "center",
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = false },
				presets = {
					motions = false,
					operators = false,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
				wo = { winblend = 0 },
			},
			expand = 1,
			sort = { group_first, "local", "order", "alphanum", "mod" },
			icons = {
				group = "",
				rules = false,
				colors = false,
				breadcrumb = "",
				separator = "➜",
				keys = {
					C = "C-",
					M = "A-",
					S = "S-",
					BS = "<BS> ",
					CR = "<CR> ",
					NL = "<NL> ",
					Esc = "<Esc> ",
					Tab = "<Tab> ",
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					Space = "<Space> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
				},
			},
			spec = {
				{ "<leader>d", group = "  Debug" },
				{ "<leader>l", group = "󱜙  LSP" },
				{ "<leader>m", group = "  Marks" },
				{ "<leader>t", group = "  Telescope" },
			},
		})
	end,
}
