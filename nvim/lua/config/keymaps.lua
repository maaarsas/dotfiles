-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Neovim 0.11+ already maps grr (references), gri (implementation),
-- grn (rename), gra (code action), grt (type definition), gO (symbols),
-- K (hover) and <C-s> (signature help, insert mode). Only the gaps below.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
	callback = function(ev)
		local map = function(keys, fn, desc)
			vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
		end
		map("gd", vim.lsp.buf.definition, "Goto definition")
		map("gD", vim.lsp.buf.declaration, "Goto declaration")
		map("gy", vim.lsp.buf.type_definition, "Goto type definition")
		map("<leader>e", vim.diagnostic.open_float, "Line diagnostics")

		-- inline parameter names and inferred types, where the server offers them
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, "Toggle inlay hints")
		end
	end,
})
