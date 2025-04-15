return {
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',
	version = "1.*",

	opts = {
		keymap = { preset = 'default' },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    },

		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},

		signature = { enabled = true }
	},
}
