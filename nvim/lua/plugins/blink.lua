return {
	{
		"saghen/blink.cmp", -- 124
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		-- V2 is under active development with breaking changes and needs blink.lib;
		-- a release tag also means a prebuilt Rust binary instead of a cargo build.
		version = "1.*",
		opts = {
			-- default: <C-space> open, <C-y> accept, <C-n>/<C-p> navigate
			-- other presets: "super-tab", "enter"
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				menu = {
					border = "rounded",
					draw = {
						treesitter = { "lsp" }, -- colour labels like code, not plain text
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				ghost_text = { enabled = true },
			},
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true, window = { border = "rounded" } },
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			require("blink.cmp").setup(opts)

			-- blink links every BlinkCmpKind* to PmenuKind, which darcula-solid
			-- links to Pmenu: one flat colour for all icons
			local kinds_by_group = {
				Function = { "Function", "Method", "Constructor" },
				Identifier = { "Variable", "Field", "Property", "Reference" },
				Type = { "Class", "Interface", "Struct", "Enum", "Module", "TypeParameter" },
				Constant = { "Constant", "EnumMember", "Keyword" },
				Number = { "Value", "Unit" },
				String = { "Text" },
				Directory = { "File", "Folder" },
				Special = { "Snippet", "Color", "Event", "Operator" },
			}

			local function set_highlights()
				for group, kinds in pairs(kinds_by_group) do
					for _, kind in ipairs(kinds) do
						vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { link = group })
					end
				end
				-- the fuzzy-matched characters get no highlight at all by default
				vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", {
					fg = vim.api.nvim_get_hl(0, { name = "Number", link = false }).fg,
					bold = true,
				})
			end

			set_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("BlinkCmpKindColors", { clear = true }),
				callback = set_highlights,
			})
		end,
	},
}
