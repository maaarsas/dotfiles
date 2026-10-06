return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    init = function()
      -- ufo needs a large foldlevel: files open unfolded instead of collapsed
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      -- only {main, fallback} is allowed here -- ufo rejects longer chains,
      -- so pick the pair per filetype instead
      provider_selector = function(_, filetype, _)
        local has_lsp = {
          go = true,
          gomod = true,
          lua = true,
          ruby = true,
        }
        if has_lsp[filetype] then
          return { "lsp", "indent" }
        end
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },
}
