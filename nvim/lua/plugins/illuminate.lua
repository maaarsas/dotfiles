return {
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = {
			delay = 150,
			providers = { "lsp", "treesitter", "regex" },
			large_file_cutoff = 2000,
			filetypes_denylist = {
				"neo-tree",
				"trouble",
				"Trouble",
				"lazy",
				"mason",
				"help",
				"gitcommit",
				"dap-repl",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
