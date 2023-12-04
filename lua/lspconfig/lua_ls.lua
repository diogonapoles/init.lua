-- -- retrieved from: https://gitlab.com/sairy/neovim/-/blob/693f3151751264f8952b2ae409a4fcb58de3a8f4/lua/lsp/clients/sumneko.lua
-- --  _              --
-- -- | |_   _  __ _  --
-- -- | | | | |/ _` | --
-- -- | | |_| | (_| | --
-- -- |_|\__,_|\__,_| --
-- --                 --
-- ---@diagnostic disable: missing-fields
-- local utils = require("lspconfig.util")
--
-- ---@type string[], string[]
-- local rtp, lib = {}, {}
-- local num, version = "5.1", "LuaJIT"
--
-- if
-- 	vim
-- 		.fn
-- 		.expand("%:p:h") --[[@as string]]
-- 		:match(vim.fn.stdpath("config"))
-- then
-- 	-- we're in neovim
-- 	rtp = vim.split(package.path, ";")
-- 	rtp[#rtp + 1] = "lua/?.lua"
-- 	rtp[#rtp + 1] = "lua/?/init.lua"
--
-- 	lib = vim.api.nvim_get_runtime_file("", true)
-- 	lib[#lib + 1] = "${3rd}/luv/library"
-- else
-- 	local str = [[
--     t = { _VERSION, package.path, tostring(pcall(require, 'luarocks.loader')) }
--     io.stdout:write(table.concat(t, '\f'))
-- ]]
--
-- 	local rv = vim.system({ "/usr/bin/env", "lua", "-e", str }, { text = true }):wait()
--
-- 	local ver, path, has_rocks = unpack(vim.split(rv.stdout, "\f"))
--
-- 	local vnum = vim.version.parse(ver) or { 5, 4 }
-- 	num = string.format("%d.%d", vnum[1], vnum[2])
-- 	version = "Lua " .. num
--
-- 	rtp = vim.split(path, ";")
-- 	-- rtp[#rtp+1] = './?/init.lua'
--
-- 	if has_rocks == "true" then
-- 		lib[#lib + 1] = "~/.local/lib/luarocks/share/lua/" .. num
-- 		lib[#lib + 1] = "~/.local/lib/luarocks/lib/lua/" .. num
-- 	end
-- end
--
-- lib[#lib + 1] = "/usr/share/lua/" .. num
--
-- ---@type lsp_client_cfg
-- local M = {
-- 	cmd = { "lua-language-server" },
--
-- 	filetypes = { "lua" },
--
-- 	log_level = 2,
--
-- 	single_file_support = true,
--
-- 	root_dir = utils.root_pattern(".git", ".luarc.json"),
--
-- 	settings = {
-- 		---@see https://github.com/LuaLS/lua-language-server/wiki/Settings
-- 		Lua = {
-- 			-- whyyyyy
-- 			telemetry = {
-- 				enable = false,
-- 			},
--
-- 			completion = {
-- 				callSnippet = "Both",
-- 			},
--
-- 			runtime = {
-- 				version = version,
-- 				path = rtp,
-- 			},
--
-- 			hint = {
-- 				enable = true,
-- 				arrayIndex = "Disable",
-- 				await = true,
-- 				paramName = "Disable",
-- 				paramType = false,
-- 				semicolon = "Disable",
-- 				setType = true,
-- 			},
--
-- 			format = {
-- 				enable = true,
-- 				defaultConfig = require("lspconfig").lua_ls,
-- 			},
--
-- 			semantic = {
-- 				enable = true,
-- 				annotation = true,
-- 				keyword = false,
-- 				variable = true,
-- 			},
--
-- 			workspace = {
-- 				library = lib,
-- 				checkThirdParty = false,
-- 				useGitIgnore = true,
-- 				maxPreload = 100000,
-- 				preloadFileSize = 10000,
-- 			},
-- 		},
-- 	},
-- }
--
-- ---Injected properties
-- M.__repl_opts = {
-- 	cmd = version:match("LuaJIT") and "luajit" or "lua",
-- }
--
-- return M
