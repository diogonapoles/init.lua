return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"blink.cmp",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local opts = { capabilities = capabilities }
		local servers = {
			ts_ls = opts,
			lua_ls = opts,
			terraformls = opts,
		}

		for lsp, opts in pairs(servers) do
			lspconfig[lsp].setup(opts)
		end
	end,
}
