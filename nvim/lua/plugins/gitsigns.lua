return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { delay = 1000, virt_text_pos = "eol" },
		},
		keys = {
			{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle inline blame" },
			{
				"<leader>gB",
				function()
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "gitsigns-blame" then
							return vim.api.nvim_win_close(win, true)
						end
					end
					-- with every window fixed-width, vsplit takes the blame's columns from neo-tree
					vim.wo.winfixwidth = false
					require("gitsigns").blame()
				end,
				desc = "Toggle blame split",
			},
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
