return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- git status per tab
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy", -- must load at startup, or the tabline never renders
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		keys = {
			{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
			{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Next buffer" },
			{ "<leader>bd", "<cmd>BufferClose<cr>", desc = "Close buffer (keep layout)" },
			{ "<leader>bp", "<cmd>BufferPin<cr>", desc = "Pin buffer" },
			{ "<leader>bb", "<cmd>BufferPick<cr>", desc = "Jump to buffer by letter" },
			{ "<leader>bo", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close other buffers" },
		},
		opts = {
			icons = {
				-- ERROR and HINT are on by default; WARN is not
				diagnostics = {
					[vim.diagnostic.severity.WARN] = { enabled = true },
				},
			},
			-- shift the tabline right when neo-tree is open (defaults cover NvimTree)
			sidebar_filetypes = {
				["neo-tree"] = { event = "BufWipeout", text = "File Explorer" },
			},
		},
	},
}
