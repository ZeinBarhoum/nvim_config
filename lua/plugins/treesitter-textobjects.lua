return { -- Treesitter-aware text objects: select/move/swap by function, class, parameter
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main", -- must match the `main` pin in treesitter.lua
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	init = function()
		-- Suppress the plugin's own default mappings; every key below is set explicitly.
		vim.g.no_plugin_maps = true
	end,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Jump forward to the next match when the cursor is not already inside one.
				lookahead = true,
			},
			move = {
				set_jumps = true, -- record moves in the jumplist, so <C-o> comes back
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		-- Second arg is the query *group*, not a capture: these all live in textobjects.scm
		local function sel(key, capture, desc)
			vim.keymap.set({ "x", "o" }, key, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = desc })
		end

		local function goto_map(key, fn, capture, desc)
			vim.keymap.set({ "n", "x", "o" }, key, function()
				fn(capture, "textobjects")
			end, { desc = desc })
		end

		-- Select.
		-- NOTE: `ai`/`ii` are deliberately NOT used for conditionals -- vim-indent-object
		-- owns them. `ab`/`ib`, `as`/`is` and `ap`/`ip` are builtin (block, sentence,
		-- paragraph) and are likewise left alone.
		sel("af", "@function.outer", "a function")
		sel("if", "@function.inner", "inner function")
		sel("ac", "@class.outer", "a class")
		sel("ic", "@class.inner", "inner class")
		sel("aa", "@parameter.outer", "a parameter/argument")
		sel("ia", "@parameter.inner", "inner parameter/argument")
		sel("ao", "@loop.outer", "a loop")
		sel("io", "@loop.inner", "inner loop")
		sel("a=", "@assignment.outer", "an assignment")
		sel("i=", "@assignment.inner", "inner assignment")

		-- Move.
		-- NOTE: no class motion on `]c`/`[c` -- gitsigns owns those for hunks.
		goto_map("]f", move.goto_next_start, "@function.outer", "Next function start")
		goto_map("[f", move.goto_previous_start, "@function.outer", "Previous function start")
		goto_map("]F", move.goto_next_end, "@function.outer", "Next function end")
		goto_map("[F", move.goto_previous_end, "@function.outer", "Previous function end")
		goto_map("]a", move.goto_next_start, "@parameter.inner", "Next parameter")
		goto_map("[a", move.goto_previous_start, "@parameter.inner", "Previous parameter")
		goto_map("]l", move.goto_next_start, "@loop.outer", "Next loop")
		goto_map("[l", move.goto_previous_start, "@loop.outer", "Previous loop")

		-- Swap. Under <leader>c ([C]ode) because <leader>a is the AI group.
		vim.keymap.set("n", "<leader>cs", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "[C]ode [S]wap parameter with next" })
		vim.keymap.set("n", "<leader>cS", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "[C]ode [S]wap parameter with previous" })

		-- NOTE: the `repeatable_move` module (which rebinds `;`/`,` so the motions above
		-- repeat) is intentionally not enabled -- flash.nvim's char mode already owns
		-- `;`/`,` for f/t/F/T. Enable one or the other, not both.
	end,
}
