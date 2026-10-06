return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- Prebuilt binaries: mason downloads a release, no runtime needed.
      -- prettierd is the exception here -- it needs node/npm on PATH.
      ensure_installed = {
        "tree-sitter-cli", -- prebuilt release binary; required by nvim-treesitter
        "stylua",
        "shfmt",
        "yamlfmt",
        "goimports", -- built via `go install`, needs the Go toolchain
        "prettierd", -- npm package, needs node
      },
      run_on_start = true,
    },
  },
}
