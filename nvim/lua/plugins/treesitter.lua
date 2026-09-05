return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- the main-branch rewrite does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "go",
        "gomod",
        "gosum",
        "gowork",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
      })

      -- The rewrite enables no features by default -- highlighting has to be
      -- turned on per-filetype. Folding is left to nvim-ufo.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "go",
          "gomod",
          "gosum",
          "gowork",
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "sh",
          "json",
          "yaml",
          "toml",
          "markdown",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
