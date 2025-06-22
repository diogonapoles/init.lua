return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
    lazy = false, -- neo-tree will lazily load itself
  dependencies = {
    "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim" ,
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "left" })
      end,
      desc = "Explorer (root dir)",
      remap = true,
    },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },

    window = {
      width = 30,
      mappings = {
        ["<space>"] = false, 
      },
      fuzzy_finder_mappings = { 
        ["<C-j>"] = "move_cursor_down",
        ["<C-k>"] = "move_cursor_up",
      },
    },

    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      follow_current_file = { enabled = false, leave_dirs_open = true },
      hijack_netrw_behavior = "open_current",
    },
  },
}
