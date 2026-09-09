return {
	{
		-- nvim-lspconfig ships the base config for each server in its lsp/ dir;
		-- vim.lsp.config merges on top and vim.lsp.enable starts them. mason-lspconfig
		-- only added ensure_installed on top of this, at ~36ms of startup.
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "b0o/schemastore.nvim" },
		config = function()
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
							-- "at least one file in a package should have a package
							-- comment" -- golangci-lint excludes this too, so it is
							-- editor-only noise
							ST1000 = false,
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

			-- SchemaStore catalogue: compose files, k8s manifests, CI configs
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						-- yamlls' own store would fight schemastore's
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
						validate = true,
						keyOrdering = false, -- otherwise every unsorted key is a warning
					},
				},
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Language features only; rubocop below owns lint and format, the same
			-- split as gopls / golangci_lint_ls.
			-- Not via mason: its binstub hardcodes a shebang to one ruby, so every
			-- project would run that version instead of its own .ruby-version.
			-- Resolved from PATH (mise shims) so each project gets its own.
			vim.lsp.config("ruby_lsp", {
				init_options = {
					formatter = "none",
					linters = {},
				},
			})

			-- bundle exec: every repo pins its own rubocop, and rubocop-rails only
			-- loads from the project bundle.
			-- lspconfig's default root_markers include ".git", which would start
			-- this in any repo and fail with "no Gemfile"
			vim.lsp.config("rubocop", {
				cmd = { "bundle", "exec", "rubocop", "--lsp" },
				root_markers = { "Gemfile" },
				workspace_required = true,
			})

			-- bashls runs shellcheck itself when it is on PATH (see Brewfile)
			vim.lsp.enable({
				"gopls",
				"golangci_lint_ls",
				"lua_ls",
				"yamlls",
				"jsonls",
				"bashls",
				"ruby_lsp",
				"rubocop",
			})
		end,
	},
}
