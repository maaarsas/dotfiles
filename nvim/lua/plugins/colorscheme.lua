return {
	{
		"brargenzilian/darcula-solid.nvim",
		lazy = false, -- the theme has to apply at startup
		priority = 1000, -- load before other plugins so nothing renders unstyled
		config = function()
			vim.cmd.colorscheme("darcula-solid")
		end,
	},
}
