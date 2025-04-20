return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
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
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local opts = { capabilities = capabilities }
		local servers = {
			eslint = opts,
			tailwindcss = opts,
			ts_ls = opts,
			lua_ls = opts,
			terraformls = opts,
		}

		-- mason setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		})

		-- lspconfig setup
		local lspconfig = require("lspconfig")

		for lsp, opts in pairs(servers) do
			lspconfig[lsp].setup(opts)
		end

		-- keymap setup
		vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Available code actions" }) -- in visual mode will apply to selection
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
		vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer diagnostics" })
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
		vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
	end,
}
