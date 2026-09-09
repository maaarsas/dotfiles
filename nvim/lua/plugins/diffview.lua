return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
		opts = {
			enhanced_diff_hl = true,
		},
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
			{ "<leader>gD", "<cmd>DiffviewOpen origin/HEAD...HEAD<cr>", desc = "Diff against origin/HEAD" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "History of this file" },
			{ "<leader>gh", ":DiffviewFileHistory<cr>", desc = "History of selection", mode = "v" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History of the repo" },
		},
	},
}
