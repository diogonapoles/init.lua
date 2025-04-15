return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    config = function()
			vim.opt.completeopt = {"menu", "menuone", "noselect"}
			vim.opt.shortmess:append "c"

			local lspkind = require "lspkind"
			local kind_fmt = lspkind.cmp_format {
				mode = "symbol_text",
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[api]",
					path = "[path]",
					luasnip = "[snip]",
					gh_issues = "[issues]",
					tn = "[TabNine]",
					eruby = "[erb]",
				},
			}

			require("tailwindcss-colorizer-cmp").setup {
				color_square_width = 2,
			}

			local cmp = require "cmp"
			cmp.setup {
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},

				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
				},

				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},

				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
					format = function(entry, vim_item)
						vim_item = kind_fmt(entry, vim_item)
						vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

						return vim_item
					end,
				},

				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},

				window = {},
			}
    end,
  },
}
