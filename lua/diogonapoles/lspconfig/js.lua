return {
	name = "ts_ls",
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
	},

	root_markers = { ".git", "package.json", "tsconfig.json", "jsconfig.json" },
	workspace_required = false,

	init_options = {
		hostInfo = "neovim",
	},

	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},

	on_attach = function(client)
		if vim.fn.executable("node") == 1 then
			client.config.__repl_opts = { cmd = "node" }
		end
	end,
}

