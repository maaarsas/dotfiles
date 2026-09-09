return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { delay = 5000, virt_text_pos = "eol" },
		},
		keys = {
			{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle inline blame" },
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)

			-- gitsigns links the blame text to NonText, which has no fg and a gray bg here
			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#585e65", italic = true })

			-- feed git hunks into nvim-scrollbar's gutter marks
			pcall(function()
				require("scrollbar.handlers.gitsigns").setup()
			end)
		end,
	},
}
