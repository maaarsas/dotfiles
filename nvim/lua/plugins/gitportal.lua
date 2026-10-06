return {
	{
		-- not on github, so lazy needs the full clone url
		url = "https://codeberg.org/trevorhauter/gitportal.nvim",
		cmd = "GitPortal",
		keys = {
			{
				"<leader>go",
				function()
					require("gitportal").to_remote()
				end,
				mode = { "n", "v" },
				desc = "Open file on remote",
			},
			{
				"<leader>gy",
				function()
					require("gitportal").clip_remote()
				end,
				mode = { "n", "v" },
				desc = "Copy remote URL",
			},
			{
				"<leader>gi",
				function()
					require("gitportal").from_remote()
				end,
				desc = "Open remote URL in nvim",
			},
		},
		opts = {
			always_include_current_line = true,
			always_use_commit_hash_in_url = true,
		},
	},
}
