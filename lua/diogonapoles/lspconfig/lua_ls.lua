local function query_lua_paths()
	local rtp, lib = {}, {}
	local num, version = "5.1", "LuaJIT"

	-- fs_realpath used to avoid confusion from symlinks
	local config_dir = vim.uv.fs_realpath(vim.fn.stdpath("config")) or ""
	if vim.fn.expand("%:p:h"):match(config_dir) then
		-- we're in neovim
		rtp = vim.split(package.path, ";")
		rtp[#rtp + 1] = "lua/?.lua"
		rtp[#rtp + 1] = "lua/?/init.lua"

		---@see https://github.com/neovim/nvim-lspconfig/issues/3189
		-- lib = vim.api.nvim_get_runtime_file('', true)
		lib[#lib + 1] = vim.env.VIMRUNTIME
		lib[#lib + 1] = "${3rd}/luv/library"

		local ok, lazy_cfg = pcall(require, "lazy.core.config")
		if ok then
			lib[#lib + 1] = lazy_cfg.options.root
		end
	else
		local str = [[
            t = { _VERSION, package.path }
            io.stdout:write(table.concat(t, '\f'))
        ]]

		local rv = vim.system({ "/usr/bin/env", "lua", "-e", str }, { text = true }):wait()

		local ver, path = unpack(vim.split(rv.stdout, "\f"))

		local vnum = vim.version.parse(ver) or { 5, 4 }
		num = string.format("%d.%d", vnum[1], vnum[2])
		version = "Lua " .. num

		rtp = vim.split(path, ";")
		-- rtp[#rtp+1] = './?/init.lua'
	end

	lib[#lib + 1] = "/usr/share/lua/" .. num

	return version, rtp, lib
end

local M = {
	name = "lua_ls",

	cmd = { "lua-language-server" },

	filetypes = { "lua" },

	log_level = 2,

	workspace_required = false,

	root_markers = { ".git", ".luarc.json" },

	settings = {
		---@see https://github.com/LuaLS/lua-language-server/wiki/Settings
		Lua = {
			-- whyyyyy
			telemetry = {
				enable = false,
			},

			completion = {
				callSnippet = "Both",
			},

			hint = {
				enable = true,
				arrayIndex = "Disable",
				await = true,
				paramName = "Disable",
				paramType = false,
				semicolon = "Disable",
				setType = true,
			},

			semantic = {
				enable = true,
				annotation = true,
				keyword = false,
				variable = true,
			},
		},
	},

	before_init = function(_, config)
		local version, rtp, lib = query_lua_paths()

		---@type table
		config.settings.Lua = vim.tbl_deep_extend("force", config.settings.Lua --[[@as table]], {
			runtime = {
				version = version,
				path = rtp,
			},

			workspace = {
				library = lib,
				checkThirdParty = false,
				useGitIgnore = true,
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		})

		---Injected properties
		config.__repl_opts = {
			cmd = version:match("LuaJIT") and "luajit" or "lua",
		}
	end,
}

return M
