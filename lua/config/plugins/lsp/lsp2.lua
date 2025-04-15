return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			ft = "lua",
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

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then 
					return 
				end
			end,
		})
	end,
}
