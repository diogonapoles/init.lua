return {
	name = "jsonls",
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },

	root_markers = { ".git" },
	workspace_required = false,
}

