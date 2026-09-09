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
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
			},
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
