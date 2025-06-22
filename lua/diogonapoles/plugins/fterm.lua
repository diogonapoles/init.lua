return {
	"numToStr/FTerm.nvim",
	keys = {
		{ "<C-/>", desc = "Toggle floating term" },
	},
	cond = function()
		return vim.uv.os_get_passwd().uid ~= 0
	end,
	config = function()
		local Terminal = require("FTerm.terminal")

		local _open = Terminal.open
		function Terminal:open()
			local this = _open(self)

			vim.api.nvim_exec_autocmds("User", {
				pattern = "FTermOpen",
				data = { term = this },
			})

			return this
		end

		local add_backdrop = function(bufnr, opts)
			opts = vim.tbl_extend("keep", opts or {}, {
				highlight = "Backdrop",
				blend = 50,
				zindex = 50,
				respect_transparent_bg = true,
			})

			local is_transparent = function()
				local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
				return normal.bg == nil
			end

			local backdrop_bufnr = vim.api.nvim_create_buf(false, true)
			local winid = vim.api.nvim_open_win(backdrop_bufnr, false, {
				relative = "editor",
				row = 0,
				col = 0,
				width = vim.o.columns,
				height = vim.o.lines,
				focusable = false,
				style = "minimal",
				zindex = opts.zindex - 1,
				hide = opts.respect_transparent_bg and is_transparent(),
			})

			local hl_name
			if type(opts.highlight) == "table" then
				hl_name = "Backdrop" .. vim.bo[bufnr].filetype

				local bg = opts.highlight.bg or "#000000"
				vim.api.nvim_set_hl(0, hl_name, { bg = bg, default = true })
			else
				hl_name = opts.highlight
			end

			vim.wo[winid].winhighlight = "Normal:" .. hl_name
			vim.wo[winid].winblend = opts.blend
			vim.bo[backdrop_bufnr].buftype = "nofile"

			-- close backdrop when the reference buffer is closed
			vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
				once = true,
				buffer = bufnr,
				callback = function()
					if vim.api.nvim_win_is_valid(winid) then
						vim.api.nvim_win_close(winid, true)
					end
					if vim.api.nvim_buf_is_valid(backdrop_bufnr) then
						vim.api.nvim_buf_delete(backdrop_bufnr, { force = true })
					end
				end,
			})

			if opts.respect_transparent_bg then
				vim.api.nvim_create_autocmd("ColorScheme", {
					buffer = bufnr,
					callback = function()
						vim.api.nvim_win_set_config(winid, {
							hide = is_transparent(),
						})
					end,
				})
			end
		end

		local fterm = require("FTerm")

		fterm.setup({
			ft = "Fterm",

			cmd = vim.o.shell,

			border = "rounded",

			auto_close = true,

			hl = "NormalFloat",

			blend = 0,

			dimensions = {
				width = 0.8,
				height = 0.8,
				x = 0.5,
				y = 0.5,
			},

			on_exit = nil,
			on_stdout = nil,
			on_stderr = nil,
			env = nil,
			clear_env = false,
		})

		vim.keymap.set("n", "<C-/>", fterm.toggle, { desc = "Toggle floating term" })
		vim.keymap.set("t", "<C-/>", fterm.toggle, { desc = "Toggle floating term" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "FTermOpen",
			group = vim.api.nvim_create_augroup("fterm::backdrop", { clear = true }),
			callback = function(args)
				local term = args.data.term
				add_backdrop(term.buf)
			end,
		})
	end,
}
