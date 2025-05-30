return {
	"bullets-vim/bullets.vim",
	ft = { "markdown", "text", "gitcommit", "scratch" },
	config = function()
		-- 2 works similar as Obsidian https://github.com/bullets-vim/bullets.vim/pull/163
		vim.g.bullets_delete_last_bullet_if_empty = 2
	end,
}
