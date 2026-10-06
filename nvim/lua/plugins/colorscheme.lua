return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- the theme has to apply at startup
		priority = 1000, -- load before other plugins so nothing renders unstyled
		config = function()
			require("kanagawa").setup({
				overrides = function()
					return {
						BlinkCmpMenu = { link = "NormalFloat" },
						BlinkCmpMenuBorder = { link = "FloatBorder" },
					}
				end,
			})
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},
}
