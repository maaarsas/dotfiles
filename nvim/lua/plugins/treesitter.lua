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
        "ruby",
        "embedded_template",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "make",
        "sql",
        "gitcommit",
      })

      -- The rewrite enables no features by default -- highlighting and folding
      -- have to be turned on per-filetype.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "go",
          "gomod",
          "gosum",
          "gowork",
          "ruby",
          "eruby",
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "sh",
          "json",
          "yaml",
          "toml",
          "markdown",
          "dockerfile",
          "make",
          "sql",
          "gitcommit",
        },
        callback = function()
          vim.treesitter.start()
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },
}
