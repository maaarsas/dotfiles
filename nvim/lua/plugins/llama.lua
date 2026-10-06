return {
	{
		"ggml-org/llama.vim",
		event = "VeryLazy",
		init = function()
			-- auto_fim off: the plugin's own CursorMovedI handlers probe the
			-- completion cache synchronously on every keystroke, so the
			-- debounced handler below drives FIM instead
			vim.g.llama_config = {
				show_info = 0,
				auto_fim = false,
				model_fim = "ggml-org/Qwen2.5-Coder-3B-Q8_0-GGUF",
			}
		end,
		config = function()
			local group = vim.api.nvim_create_augroup("llama_blink", { clear = true })
			local debounce_ms = 100

			-- llama.vim ships no default for this group on nvim, so the ghost
			-- text would otherwise render at Normal
			local function set_highlight()
				vim.api.nvim_set_hl(0, "llama_hl_fim_hint", { link = "Conceal" })
			end

			set_highlight()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = group,
				callback = set_highlight,
			})

			local timer = vim.uv.new_timer()
			local menu_open = false
			local enabled = true

			local function request()
				if menu_open or not enabled or not vim.startswith(vim.fn.mode(), "i") then
					return
				end
				vim.fn["llama#fim_inline"](true, true)
			end

			vim.api.nvim_create_autocmd("CursorMovedI", {
				group = group,
				callback = function()
					vim.fn["llama#fim_hide"]()
					timer:stop()
					timer:start(debounce_ms, 0, vim.schedule_wrap(request))
				end,
			})

			vim.api.nvim_create_autocmd("InsertLeave", {
				group = group,
				callback = function()
					timer:stop()
				end,
			})

			-- blink draws its own menu, so llama's built-in CompleteChanged hook never fires
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					menu_open = true
					timer:stop()
					vim.fn["llama#fim_hide"]()
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "BlinkCmpMenuClose",
				callback = function()
					menu_open = false
				end,
			})

			-- LlamaEnable/LlamaDisable are global, not per-buffer
			local skip = { gitcommit = true, gitrebase = true, markdown = true, [""] = true }
			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
				group = group,
				callback = function(args)
					local want = not skip[vim.bo[args.buf].filetype]
					if want == enabled then
						return
					end
					enabled = want
					vim.cmd(want and "LlamaEnable" or "LlamaDisable")
				end,
			})
		end,
	},
}
