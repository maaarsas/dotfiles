return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				go = { "goimports" }, -- supersedes gofmt: also adds/removes imports
				-- ruby: no entry on purpose. default_format_opts lsp_format = "fallback"
				-- sends it to ruby-lsp, whose rubocop addon runs in the project bundle.
				-- conform would spawn `bundle` with nvim's cwd (it passes cwd = nil).
				eruby = { "erb_format" },
				lua = { "stylua" },
				sh = { "shfmt" },
				json = { "jq" },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			-- filetypes without an entry above fall back to their language server
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = function(bufnr)
				-- this buffer only:  :lua vim.b.disable_autoformat = true
				-- everywhere:        :lua vim.g.disable_autoformat = true
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
					return
				end
				return { timeout_ms = 500 }
			end,
		},
		config = function(_, opts)
			require("conform").setup(opts)

			-- :FormatDisable  -> everywhere,  :FormatDisable! -> current buffer
			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, { bang = true, desc = "Disable format-on-save" })

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "Re-enable format-on-save" })
		end,
	},
}
