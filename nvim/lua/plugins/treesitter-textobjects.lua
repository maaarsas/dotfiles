return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main", -- matches the nvim-treesitter rewrite
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true, -- jump forward to the textobject, like targets.vim
					selection_modes = {
						["@function.outer"] = "V", -- linewise; default is charwise
					},
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			-- select: daf deletes a function, cif replaces its body, dia drops a param
			local objects = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer", -- struct/type in Go
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["a/"] = "@comment.outer",
			}
			for key, query in pairs(objects) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end, { desc = "Select " .. query })
			end

			-- move between functions and types
			local moves = {
				["]f"] = { move.goto_next_start, "@function.outer" },
				["]F"] = { move.goto_next_end, "@function.outer" },
				["[f"] = { move.goto_previous_start, "@function.outer" },
				["[F"] = { move.goto_previous_end, "@function.outer" },
				["]c"] = { move.goto_next_start, "@class.outer" },
				["[c"] = { move.goto_previous_start, "@class.outer" },
			}
			for key, spec in pairs(moves) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					spec[1](spec[2], "textobjects")
				end, { desc = "Move to " .. spec[2] })
			end

			-- swap parameters, for reordering function arguments
			vim.keymap.set("n", "<leader>sa", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap parameter with next" })
			vim.keymap.set("n", "<leader>sA", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap parameter with previous" })
		end,
	},
}
