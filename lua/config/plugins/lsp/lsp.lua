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

		lspconfig.lua_ls.setup({ capabilities = capabilities })
		lspconfig.terraformls.setup({ capabilities = capabilities })
	end,
}
