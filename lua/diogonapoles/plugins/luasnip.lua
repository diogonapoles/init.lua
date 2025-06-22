return {
	"L3MON4D3/LuaSnip",
	dependencies = "rafamadriz/friendly-snippets",
	config = function()
		local luasnip = require("luasnip")

		luasnip.config.set_config({
			history = false,
			update_events = { "TextChanged", "TextChangedI" },
			region_check_events = "CursorMoved",
			delete_check_events = "TextChanged",
		})

		luasnip.filetype_extend("javascript", { "jsdoc" })
		luasnip.filetype_extend("typescript", { "tsdoc" })
		luasnip.filetype_extend("lua", { "luadoc" })

		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
