vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Put mise shims first on PATH so LSP servers and formatters spawned by nvim
-- (gopls' toolchain, golangci-lint-langserver's linter) use the versions pinned
-- in the project's .tool-versions instead of $HOME/go/bin or homebrew.
-- Applies even when nvim is launched outside a shell that has mise on PATH.
vim.env.PATH = vim.fn.expand("~/.local/share/mise/shims") .. ":" .. vim.env.PATH

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
-- foldinner blanks the nesting-level digits a 1-wide fold column would print
opt.fillchars = { fold = " ", foldopen = "▼", foldclose = "▶", foldinner = " ", foldsep = " " }
opt.foldcolumn = "1"
opt.foldlevel = 99 -- files open unfolded
opt.foldlevelstart = 99
opt.foldmethod = "indent" -- treesitter takes over where a parser is available
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = "→→", space = "·", nbsp = "␣" }
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Show line numbers
opt.relativenumber = false -- Absolute line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions =
	{ "blank", "buffers", "curdir", "folds", "help", "localoptions", "tabpages", "terminal", "winpos", "winsize" }
opt.sidescrolloff = 8 -- Columns of context
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- lualine already shows the mode
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true
opt.updatetime = 250 -- neotest refreshes on CursorHold; the 4s default is too slow
opt.undolevels = 10000
opt.winminwidth = 5 -- Minimum window width

vim.diagnostic.config({
	severity_sort = true,
	underline = true,
	virtual_text = { current_line = false, prefix = "■", spacing = 2 },
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	float = { border = "rounded", source = true },
})
