return {
	{
		"brargenzilian/darcula-solid.nvim",
		priority = 1000, -- load before other plugins so nothing renders unstyled
		config = function()
			vim.cmd.colorscheme("darcula-solid")
		end,
	},
}
