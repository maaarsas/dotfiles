return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
			},
			-- inline variable values as virtual text while stepping
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
			{ "leoluz/nvim-dap-go", opts = {} },
			-- rdbg from the debug gem; its configurations are picked via <leader>dc
			{ "suketa/nvim-dap-ruby", opts = {} },
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Conditional breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue / start",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate session",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Inspect value under cursor",
			},
			-- Go-specific: debug the test or nearest function under the cursor
			{
				"<leader>dgt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "Debug nearest Go test",
			},
			{
				"<leader>dgl",
				function()
					require("dap-go").debug_last_test()
				end,
				desc = "Debug last Go test",
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- nvim-dap-ruby spawns rdbg, waits a fixed `waiting` ms, then connects blind.
			-- Booting Rails takes a couple of seconds, so the 1s that neotest-rspec asks for
			-- always hits a closed port -> "debug adapter disconnected". Poll instead.
			local spawn_ruby = dap.adapters.ruby
			if spawn_ruby then
				dap.adapters.ruby = function(callback, config)
					spawn_ruby(function(adapter)
						local host, port = adapter.host, tonumber(adapter.port)
						local deadline = vim.uv.now() + 60000
						local function poll()
							local sock = vim.uv.new_tcp()
							sock:connect(host, port, function(err)
								sock:close()
								if not err then
									vim.schedule(function()
										callback(adapter)
									end)
								elseif vim.uv.now() < deadline then
									vim.defer_fn(poll, 100)
								else
									vim.schedule(function()
										vim.notify(
											("rdbg never opened %s:%s"):format(host, port),
											vim.log.levels.ERROR
										)
									end)
								end
							end)
						end
						poll()
					end, vim.tbl_extend("force", config, { waiting = 0 }))
				end
			end

			-- nvim-dap-ruby sets these on nvim's own environment, so they would otherwise leak
			-- into every later (non-debug) test run and make rspec reopen a stale port.
			local function clear_ruby_debug_env()
				vim.env.RUBY_DEBUG_OPEN = nil
				vim.env.RUBY_DEBUG_HOST = nil
				vim.env.RUBY_DEBUG_PORT = nil
			end
			dap.listeners.after.event_terminated.ruby_env = clear_ruby_debug_env
			dap.listeners.after.event_exited.ruby_env = clear_ruby_debug_env

			-- open the UI automatically when a session starts, close when it ends
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })
		end,
	},
}
