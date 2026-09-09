return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- puts its bin dir on PATH, which conform and the LSPs need
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- Prebuilt binaries: mason downloads a release, no runtime needed.
      -- prettierd is the exception here -- it needs node/npm on PATH.
      -- Names here are mason package names, not lspconfig server names.
      ensure_installed = {
        "tree-sitter-cli", -- prebuilt release binary; required by nvim-treesitter
        "stylua",
        "shfmt",
        "yamlfmt",
        "goimports", -- built via `go install`, needs the Go toolchain
        "delve", -- Go debugger, used by nvim-dap-go
        "prettierd", -- npm package, needs node
        -- language servers, enabled in lspconfig.lua
        "gopls",
        "golangci-lint-langserver",
        "lua-language-server",
        "yaml-language-server",
        "json-lsp",
        "bash-language-server",
      },
      run_on_start = true,
    },
  },
}
