return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp", -- next edit suggestions
		},
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					-- <M-l> upstream, but Option is not Alt in ghostty by default
					accept = "<C-j>",
					accept_word = "<C-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				gitcommit = false,
				gitrebase = false,
				markdown = false,
				["."] = false,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- keep the two inline texts apart: hide copilot while blink's menu is up
			local group = vim.api.nvim_create_augroup("copilot_blink", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					vim.b.copilot_suggestion_hidden = true
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end,
	},
}
