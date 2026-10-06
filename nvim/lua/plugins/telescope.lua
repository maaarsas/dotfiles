return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- native fzf sorter: much faster on large repos, needs make + a C compiler
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- orders <leader>ff by frecency (recently + often opened first)
			{ "nvim-telescope/telescope-frecency.nvim", version = "*" },
		},
		cmd = "Telescope",
		keys = {
			-- files and text
			-- recently/often opened files first, then the rest of the cwd
			{ "<leader>ff", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
			-- LSP-backed: the Search Everywhere / Go to Symbol equivalents
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		},
		opts = {
			defaults = {
				path_display = { "truncate" },
			},
			pickers = {
				find_files = { hidden = true },
			},
			extensions = {
				frecency = {
					-- unscored files under the cwd are still listed (show_unindexed
					-- defaults to true), so this stays a full find_files replacement
					default_workspace = "CWD",
					show_filter_column = false,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "frecency")
		end,
	},
}
