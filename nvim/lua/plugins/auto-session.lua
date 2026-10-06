return {
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			suppressed_dirs = { "~/", "~/Downloads", "~/Desktop", "/" },
			save_and_restore_shada = true,
			-- registering the picker eagerly would drag telescope into startup
			session_lens = { load_on_setup = false },
		},
		keys = {
			{ "<leader>qs", "<cmd>AutoSession save<cr>", desc = "Save session" },
			{ "<leader>qr", "<cmd>AutoSession restore<cr>", desc = "Restore session" },
			{ "<leader>qd", "<cmd>AutoSession delete<cr>", desc = "Delete session" },
			{ "<leader>qf", "<cmd>AutoSession search<cr>", desc = "Find session" },
		},
	},
}
