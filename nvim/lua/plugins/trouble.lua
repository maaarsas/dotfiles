return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		opts = {
			focus = true,
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions / references" },
			{ "<leader>xi", "<cmd>Trouble lsp_incoming_calls toggle<cr>", desc = "Incoming calls" },
			{ "<leader>xo", "<cmd>Trouble lsp_outgoing_calls toggle<cr>", desc = "Outgoing calls" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		},
	},
}
