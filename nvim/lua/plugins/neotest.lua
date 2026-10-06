return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"fredrikaverpil/neotest-golang",
				version = "*", -- track releases
				build = function()
					-- gotestsum: optional, but the recommended runner
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
				end,
			},
			"olimorris/neotest-rspec",
		},
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run tests in file",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "Run all tests",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run last test",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "Show test output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle output panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop test run",
			},
		},
		config = function()
			local rspec = require("neotest-rspec")({
				rspec_cmd = function()
					return { "bundle", "exec", "rspec" }
				end,
			})

			-- neotest-rspec's dap strategy sets `current_line = true`, which makes nvim-dap-ruby
			-- append `expand("%:p"):line(".")` to the rspec args. The spec path is already in the
			-- command, and when the run starts from the summary window `%` is the summary buffer --
			-- rspec then dies on a bogus path before the debugger is ever attached to.
			local build_spec = rspec.build_spec
			rspec.build_spec = function(args)
				local spec = build_spec(args)
				if spec and spec.strategy then
					spec.strategy.current_line = false
					spec.strategy.current_file = false
				end
				return spec
			end

			require("neotest").setup({
				adapters = {
					require("neotest-golang")({
						runner = "gotestsum",
					}),
					rspec,
				},
			})
		end,
	},
}
