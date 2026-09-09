return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {
			indent = { char = "│", tab_char = "│" },
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"lazy",
					"lazygit",
					"mason",
					"neo-tree",
					"trouble",
					"checkhealth",
					"man",
					"gitcommit",
				},
			},
		},
	},
}
