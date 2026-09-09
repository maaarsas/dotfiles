return {
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig" },
		ft = { "go", "gomod", "gowork", "gotmpl" },
		-- install_all_sync skips tools already on PATH; update_all_sync would
		-- rebuild them, including the golangci-lint mise provides, whose install
		-- path in this plugin is broken
		build = ':lua require("go.install").install_all_sync()',
		opts = {
			-- gopls, inlay hints, formatting and dap are owned by mason-lspconfig,
			-- keymaps.lua, conform and nvim-dap-go respectively
			lsp_cfg = false,
			lsp_keymaps = false,
			lsp_inlay_hints = { enable = false },
			dap_debug = false,
			luasnip = false,
		},
		config = function(_, opts)
			require("go").setup(opts)
		end,
		keys = {
			{ "<leader>cgt", "<cmd>GoAddTag json<cr>", desc = "Go: add json struct tags" },
			{ "<leader>cgT", "<cmd>GoRmTag<cr>", desc = "Go: remove struct tags" },
			{ "<leader>cgi", "<cmd>GoImpl<cr>", desc = "Go: implement interface" },
			{ "<leader>cgf", "<cmd>GoFillStruct<cr>", desc = "Go: fill struct" },
			{ "<leader>cge", "<cmd>GoIfErr<cr>", desc = "Go: if err != nil" },
			{ "<leader>cgu", "<cmd>GoAddTest<cr>", desc = "Go: generate test for function" },
			{ "<leader>cga", "<cmd>GoAlt<cr>", desc = "Go: switch to test / impl" },
			{ "<leader>cgc", "<cmd>GoCoverage<cr>", desc = "Go: coverage in the gutter" },
			{ "<leader>cgm", "<cmd>GoModTidy<cr>", desc = "Go: mod tidy" },
			{ "<leader>cgj", "<cmd>GoJson2Struct<cr>", desc = "Go: json to struct", mode = { "n", "v" } },
		},
	},
}
