return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true, -- one statusline for all splits
        section_separators = "",
        component_separators = "|",
      },
      sections = {
        lualine_c = {
          -- path: 0 = name only, 1 = relative, 2 = absolute, 3 = absolute with ~
          { "filename", path = 1 },
        },
        lualine_y = { "lsp_status", "progress" },
      },
      extensions = { "neo-tree", "mason", "lazy" },
    },
  },
}
