return {
	"stevearc/conform.nvim",
	opts = {},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				typescript = { "prettier" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
					quiet = true,
				})
			end,
		})
	end,
}
