return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "gopls", "golangci_lint_ls", "lua_ls", "ruby_lsp" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- nvim-lspconfig ships the base config in its lsp/ dir; this merges on top
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						usePlaceholders = true, -- tab through params after accepting
						completeUnimported = true, -- suggest + auto-import unimported packages
						staticcheck = true,
						analyses = {
							unusedparams = true,
							unusedwrite = true,
							nilness = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							constantValues = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})
		end,
	},
}
