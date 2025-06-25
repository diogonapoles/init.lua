return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"jcha0713/cmp-tw2css",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")

		vim.diagnostic.config({
			float = { border = "rounded" },
		})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		lspconfig.capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		lspconfig.lua_ls.setup(require("diogonapoles.lspconfig.lua_ls"))
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.jsonls.setup(require("diogonapoles.lspconfig.json"))
		lspconfig.tailwindcss.setup({})
		lspconfig.ts_ls.setup(require("diogonapoles.lspconfig.js"))
		lspconfig.eslint.setup({
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})
        lspconfig.terraformls.setup({})

		local luasnip = require("luasnip")
		vim.api.nvim_set_hl(0, "CmpNormal", {})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),

				["<C-e>"] = cmp.mapping.abort(),
				["<C-Space>"] = cmp.mapping.complete(),

				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			window = {
				completion = {
					scrollbar = false,
					border = "rounded",
					winhighlight = "Normal:CmpNormal",
				},
				documentation = {
					scrollbar = false,
					border = "rounded",
					winhighlight = "Normal:CmpNormal",
				},
			},

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "path" },
				{ name = "buffer" },
			}),

			experimental = {
				ghost_text = true,
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "cmdline" },
				{ name = "path" },
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })

				vim.keymap.set(
					"n",
					"<leader>lrf",
					builtin.lsp_references,
					{ buffer = event.buf, desc = "View references for Word under cursor" }
				)

				vim.keymap.set(
					"n",
					"<leader>lh",
					vim.lsp.buf.hover,
					{ buffer = event.buf, desc = "Display symbol information" }
				)

				vim.keymap.set(
					"n",
					"<leader>ld",
					builtin.diagnostics,
					{ buffer = event.buf, desc = "View Buffer Diagnostics" }
				)

				vim.keymap.set(
					"n",
					"<leader>lgd",
					builtin.lsp_definitions,
					{ buffer = event.buf, desc = "Goto Definitions" }
				)

				vim.keymap.set(
					"n",
					"<leader>lic",
					builtin.lsp_incoming_calls,
					{ buffer = event.buf, desc = "View Incoming Calls" }
				)

				vim.keymap.set(
					"n",
					"<leader>loc",
					builtin.lsp_outgoing_calls,
					{ buffer = event.buf, desc = "View Outgoing Calls" }
				)

				vim.keymap.set(
					{ "n", "v" },
					"<leader>la",
					vim.lsp.buf.code_action,
					{ buffer = event.buf, desc = "View code actions" }
				)

				vim.keymap.set(
					"n",
					"<leader>lgi",
					builtin.lsp_implementations,
					{ buffer = event.buf, desc = "Goto Implementations" }
				)

				-- vim.keymap.set("n", "<leader>le", function()
				-- 	local picker = require("util.picker")({
				-- 		prompt = "LSP extra actions",
				-- 		items = {
				-- 			{
				-- 				name = " Goto Declaration",
				-- 				action = vim.lsp.buf.declaration,
				-- 			},
				-- 			{
				-- 				name = " Goto Type Definition",
				-- 				action = vim.lsp.buf.type_definition,
				-- 			},
				-- 			{
				-- 				name = " Incoming Calls",
				-- 				action = vim.lsp.buf.incoming_calls,
				-- 			},
				-- 			{
				-- 				name = "󰉺 View Implementations",
				-- 				action = vim.lsp.buf.implementation,
				-- 			},
				-- 			{
				-- 				name = "⮌ View References",
				-- 				action = vim.lsp.buf.references,
				-- 			},
				-- 			{
				-- 				name = "✚ Diagnostics to qflist",
				-- 				action = vim.diagnostic.setqflist,
				-- 			},
				-- 			{
				-- 				name = "󰡱 Toggle Inlay-Hints",
				-- 				action = function()
				-- 					local filter = { bufnr = bufnr }
				-- 					if vim.lsp.inlay_hint.is_enabled(filter) then
				-- 						vim.lsp.inlay_hint.enable(false, filter)
				-- 					else
				-- 						vim.lsp.inlay_hint.enable(true, filter)
				-- 					end
				-- 				end,
				-- 			},
				-- 		},
				-- 		config = {
				-- 			telescope = {
				-- 				theme = "dropdown",
				-- 			},
				-- 		},
				-- 	})
				-- 	return picker()
				-- end, { desc = "LSP extra actions" })

				-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				-- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				-- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				-- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
			end,
		})
	end,
}
