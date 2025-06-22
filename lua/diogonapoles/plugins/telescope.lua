return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 'nvim-telescope/telescope-ui-select.nvim', "nvim-lua/plenary.nvim", { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true, -- false only does exact matching
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                }
            },

            pickers = {
                find_files = {
                    follow = true,
                    hidden = true,

                    no_ignore = false,
                    no_ignore_parent = false,
                },

                git_files = {
                    use_git_root = true,
                    show_untracked = true,
                    recurse_submodules = false,
                },

                git_status = {
                    use_git_root = true,
                    git_icons = {
                        added = "✓",
                        changed = "✗",
                        copied = ">",
                        deleted = "",
                        renamed = "➜",
                        unmerged = "",
                        untracked = "",
                    },
                },

                help_tags = {
                    lang = vim.o.helplang,
                    fallback = true,
                },
            }
        })

        local builtin = require('telescope.builtin')

		vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>ts", builtin.live_grep, { desc = "Find string" })
		vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "Neovim help" })

        require('telescope').load_extension('fzf')
        require("telescope").load_extension("ui-select")
    end

}
