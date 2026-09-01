return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
          },
        },
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      },
    },
  },
}
