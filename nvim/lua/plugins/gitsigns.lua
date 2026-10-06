return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		config = function(_, opts)
			require("gitsigns").setup(opts)
			-- feed git hunks into nvim-scrollbar's gutter marks
			pcall(function()
				require("scrollbar.handlers.gitsigns").setup()
			end)
		end,
	},
}
